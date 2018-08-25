package be.unamur.mlvm.test.scad;


import be.unamur.mlvm.sampling.CombinatorialSampleGenerator;
import be.unamur.mlvm.scad.ScadConfigurationEvaluator;
import be.unamur.mlvm.scad.ScadModelLoader;
import be.unamur.mlvm.vm.FeatureDomain;
import be.unamur.mlvm.vm.FeatureId;
import be.unamur.mlvm.vm.VariabilityModel;
import org.json.simple.parser.ParseException;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class ScadModelsResultsGenerator {

    private static final Path OPENSCAD_PATH = Paths.get("C:", "Program Files", "OpenSCAD", "openscad.exe");
    private static final Path SLIC3R_PATH = Paths.get("C:", "Program Files", "Slic3r", "slic3r-console.exe");
    private static final Path SCAD_FILES_ROOT = Paths.get("D:", "scadFiles");

    private static final int RANGE_PARTITION = 20;
    private static final int TIMEOUT = 300 * 60 * 1000; // 10 mins

    public static void main(String[] args) throws IOException {

        List<VariabilityModel> models = listAllScadFiles()
                .map(ScadModelsResultsGenerator::loadJson)
                .flatMap(o -> o.map(Stream::of).orElseGet(Stream::empty))
                .collect(Collectors.toList());

        System.out.println("Loaded models: " + models.size());
        List<VariabilityModel> models1 = models.stream()
                .filter(x -> estimateDomainSize(x, RANGE_PARTITION) < 20000000)
                .collect(Collectors.toList());
        System.out.println("Remaining models: " + models1.size());


        Workers w = new Workers(models1, RANGE_PARTITION);
        w.runWorkers(5);
    }

    public static double estimateDomainSize(VariabilityModel model, double RANGE_PARTITION) {
        double count = 1;
        for (FeatureId f : model.features()) {
            FeatureDomain d = model.getDomain(f);
            if (d instanceof FeatureDomain.Nominal)
                count *= ((FeatureDomain.Nominal) d).getValues().size();
            else if (d instanceof FeatureDomain.Numeric) {
                double dist = ((FeatureDomain.Numeric) d).getMax() - ((FeatureDomain.Numeric) d).getMin();
                if (Double.isFinite(dist))
                    count *= RANGE_PARTITION;
                else
                    return Double.POSITIVE_INFINITY;
            }
        }
        return count;
    }

    private static Stream<Path> listFiles(Path path) {
        try {
            return Files.list(path);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    static Stream<Path> listAllScadFiles() {
        return listFiles(SCAD_FILES_ROOT)
                .flatMap(ScadModelsResultsGenerator::listFiles)
                .filter(x -> x.getFileName().toString().endsWith(".scad"));
    }

    public static Optional<VariabilityModel> loadJson(Path path) {
        try {
            return Optional.of(ScadModelLoader.load(path.toFile()));
        } catch (ScadModelLoader.UnhandledTypeException e) {
//            System.out.println("Failed to load " + path + " -> " + e.getMessage());
            return Optional.empty();
        } catch (IOException | ParseException e) {
            throw new RuntimeException(e);
        }
    }


    static class Workers {

        private final Object mutex = new Object();
        private final List<VariabilityModel> models;
        private final int rangePartition;
        private final int total;

        private AtomicInteger done = new AtomicInteger();
        private AtomicInteger timeouted = new AtomicInteger();
        private AtomicInteger runningWorkers = new AtomicInteger();

        Workers(List<VariabilityModel> models, int range_partition) {
            this.models = models;
            total = models.size();
            rangePartition = range_partition;
        }

        public void runWorkers(int count) {
            while (count-- > 0) {
                new Thread(this::runWorker).start();
            }
        }

        public void runWorker() {
            runningWorkers.incrementAndGet();
            while (true) {
                VariabilityModel p;
                synchronized (mutex) {
                    if (models.isEmpty())
                        break;
                    p = models.remove(models.size() - 1);
                }
                boolean timeout = !generateModelResults(p, rangePartition, TIMEOUT);
                synchronized (mutex) {
                    int value = done.incrementAndGet();
                    if (timeout)
                        timeouted.incrementAndGet();

                    if (getPercent(value) != getPercent(value - 1)) {
                        System.out.println("\t\t\t\t\t" + getPercent(value) + "%   (" + timeouted.get() + '/' + done.get());
                    }
                }
            }

            if (runningWorkers.decrementAndGet() == 0) {
                System.out.println("Done: " + done.get());
                System.out.println("Completed: " + (done.get() - timeouted.get()));
                System.out.println("Timeouts: " + timeouted.get());
            }
        }

        private int getPercent(int value) {
            return value * 100 / total;
        }

        private boolean generateModelResults(VariabilityModel model, int rangePartition, int timeout) {
            CombinatorialSampleGenerator gen = new CombinatorialSampleGenerator(rangePartition);

            ScadConfigurationEvaluator ev = new ScadConfigurationEvaluator(OPENSCAD_PATH, SLIC3R_PATH, SCAD_FILES_ROOT.resolve(model.getName()), model, TIMEOUT);

            if (!hasCached(model, gen, ev)) return false;

            long start = System.currentTimeMillis();
            try {
                gen.generateSamples(model, configuration -> {
                    ev.isValid(configuration);
                    if ((System.currentTimeMillis() - start) > timeout)
                        throw new RuntimeException("Timeout");
                });
                return true;
            } catch (RuntimeException e) {
                return false;
            }
        }

        private boolean hasCached(VariabilityModel model, CombinatorialSampleGenerator gen, ScadConfigurationEvaluator ev) {
            try {
                gen.generateSamples(model, configuration -> {
                    if (ev.isCached(configuration))
                        throw new RuntimeException();
                });
                return false;
            } catch (RuntimeException e) {
                return true;
            }
        }
    }

}
