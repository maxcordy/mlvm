package be.unamur.mlvm.test.scad;


import be.unamur.mlvm.sampling.CombinatorialSampleGenerator;
import be.unamur.mlvm.scad.ScadConfigurationEvaluator;
import be.unamur.mlvm.scad.ScadModelLoader;
import be.unamur.mlvm.vm.*;
import org.json.simple.parser.ParseException;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class ScadModelsTest {

    private static final Path OPENSCAD_PATH = Paths.get("C:", "Program Files", "OpenSCAD", "openscad.exe");
    private static final Path SLIC3R_PATH = Paths.get("C:", "Program Files", "Slic3r", "slic3r-console.exe");
    private static final Path SCAD_FILES_ROOT = Paths.get("d:",  "scadFiles");

    public static void main(String[] args) throws IOException {

        // return Files.list(Paths.get(TestManualSplotModels.class.getResource("../" + s).toURI()))

//        List<VariabilityModel> models = listAllScadFiles()
//                .filter(x -> !x.toString().contains("test"))
//                .map(ScadModelsTest::loadJson)
//                .flatMap(o -> o.map(Stream::of).orElseGet(Stream::empty))
//                .collect(Collectors.toList());
//
//        System.out.println("Loaded models: " + models.size());
//
//        List<VariabilityModel> finiteModels = models.stream()
//                .filter(x -> x.features().stream().filter(xx -> x.getDomain(xx) instanceof FeatureDomain.Numeric).count() == 0)
//                .collect(Collectors.toList());

//
//        for (int n = 10; n <= 10000; n *= 10) {
//            int n1 = n;
//            System.out.println("Summarizing model size with " + n + " picks : " +
//                    models.stream()
//                            .filter(x -> estimateDomainSize(x, n1) < 20000)
//                            .collect(Collectors.summarizingDouble(x -> estimateDomainSize(x, n1))));
//        }


        // test model
        List<VariabilityModel> models1 = listAllScadFiles()
                .filter(x -> x.toString().contains("test"))
                .map(ScadModelsTest::loadJson)
                .flatMap(o -> o.map(Stream::of).orElseGet(Stream::empty))
                .collect(Collectors.toList());

//
//
//        VariabilityModel model = models1.get((int) (Math.random() * models1.size()));
//
//        ScadConfigurationEvaluator ev = new ScadConfigurationEvaluator(OPENSCAD_PATH, SLIC3R_PATH,
//                SCAD_FILES_ROOT.resolve(model.getName()), model, -1);
//
//        CombinatorialSampleGenerator gen = new CombinatorialSampleGenerator(10);
//        List<Configuration> configurations = gen.generateSamples(model);


//        Map<FeatureId, FeatureValue> values = model.features().stream()
//                .collect(Collectors.toMap(x -> x, x -> new FeatureValue(x.getId().equals("a") ? 1.1111111111111107 : -10)));
//        DefaultConfiguration c1 = new DefaultConfiguration(values);
//        List<Configuration> configurations = Collections.singletonList(c1);







//
//
//
//        System.out.println(model.getName());
//        Collections.shuffle(configurations);
//
//        FeatureId[] featureIds = model.features().toArray(new FeatureId[2]);
//
//        configurations.sort((a, b) -> {
//            for (FeatureId featureId : featureIds) {
//                int x = a.valueOf(featureId).compareTo(b.valueOf(featureId));
//                if (x != 0) return x;
//            }
//            return 0;
//        });
//
//        FeatureValue line = null;
//        for (Configuration c : configurations) {
//            if (!c.valueOf(featureIds[0]).equals(line)) {
//                System.out.println();
//                line = c.valueOf(featureIds[0]);
//            }
//            System.out.print(ev.isValid(c));
//            System.out.print(" ");
//        }

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

    private static Stream<Path> listAllScadFiles() {
        return listFiles(SCAD_FILES_ROOT)
                .flatMap(ScadModelsTest::listFiles)
                .filter(x -> x.getFileName().toString().endsWith(".scad"));
    }

    private static Optional<VariabilityModel> loadJson(Path path) {
        try {
            return Optional.of(ScadModelLoader.load(path.toFile()));
        } catch (ScadModelLoader.UnhandledTypeException e) {
//            System.out.println("Failed to load " + path + " -> " + e.getMessage());
            return Optional.empty();
        } catch (IOException | ParseException e) {
            throw new RuntimeException(e);
        }
    }


}
