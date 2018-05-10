package be.unamur.mlvm.scad;

import be.unamur.mlvm.vm.*;
import org.json.simple.JSONValue;

import java.io.*;
import java.nio.file.Path;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public class ScadConfigurationEvaluator implements VariabilityModel {


    private final Path openScadPath;
    private final Path slic3rPath;
    private final Path scadFilePath;
    private final VariabilityModel model;
    private final File cachedResultsFile;
    private final Map<String, Boolean> cache = new HashMap<>();
    private long timeout;

    public ScadConfigurationEvaluator(Path openScadPath, Path slic3rPath, Path scadFilePath, VariabilityModel model, long timeout) {
        this.openScadPath = openScadPath;
        this.slic3rPath = slic3rPath;
        this.scadFilePath = scadFilePath;
        this.model = model;
        this.timeout = timeout;
        this.cachedResultsFile = getCachePath("results", ".txt");
        if (this.cachedResultsFile.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(this.cachedResultsFile))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] split = line.split("=");
                    cache.put(split[0], Boolean.parseBoolean(split[1]));
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public int getCachedCount() {
        return this.cache.size();
    }

    private boolean isVolumeValid(double volume) {
        return volume >= 1;
    }

    private boolean isSizeValid(double x, double y, double z) {
        return x >= 0.1 & y >= 0.1 && z >= 0.1;
    }

    @Override
    public boolean isValid(Configuration c) {
        return cache.computeIfAbsent(getConfigurationKey(c), key -> {
            boolean result = validateConfiguration(c, key);
            storeResult(key, result);
            return result;
        });
    }

    public boolean isCached(Configuration c) {
        return cache.containsKey(getConfigurationKey(c));
    }

    private void storeResult(String key, boolean result) {
        try (PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(this.cachedResultsFile, true)))) {
            out.print(key);
            out.print('=');
            out.println(result);
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private Boolean validateConfiguration(Configuration c, String key) {
        try {
            // stlOutput = File.createTempFile("scad_test", ".stl");
            // stlOutput.deleteOnExit();
            File stlOutput = getCachePath(key, ".stl");
            return buildSCAD(c, stlOutput) && validateSTL(stlOutput);
        } catch (IOException | InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

    private File getCachePath(String key, String extension) {
        File stlOutput;
        stlOutput = scadFilePath.toFile().getParentFile();
        stlOutput = new File(stlOutput, "generations");
        stlOutput.mkdirs();
        stlOutput = new File(stlOutput, key + extension);
        return stlOutput;
    }

    private String getConfigurationKey(Configuration c) {
        String key = model.features().stream()
                .map(feature -> feature.getId() + '=' + featureToString(c.valueOf(feature)))
                .collect(Collectors.joining(","));
        while (key.length() % 3 != 0)
            key += ' ';
        return Base64.getEncoder().encodeToString(key.getBytes());
    }

    private boolean buildSCAD(Configuration c, File output) throws IOException, InterruptedException {
        if (output.exists()) return true;

        List<String> command = new ArrayList<>();
        command.add(openScadPath.toString());
        command.add("-o");
        command.add(output.getAbsolutePath());
        model.features().forEach(feature -> {
            command.add("-D");
            command.add(JSONValue.toJSONString(feature.getId() + '=' + featureToString(c.valueOf(feature))));
        });
        command.add(scadFilePath.toString());

//        System.out.println("Starting OpenSCAD:");
        long now = System.currentTimeMillis();
        Process scad = new ProcessBuilder(command).redirectError(ProcessBuilder.Redirect.PIPE).start();

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(scad.getErrorStream()))) {

//            System.out.println("> " + command.stream().collect(Collectors.joining(" ")));
            waitFor(scad);
            double time = (System.currentTimeMillis() - now) * 0.001;
//            System.out.printf("OpenSCAD exited with code %d in %.2fs\n", resp, time);


            if (scad.exitValue() != 0) {
                return false;
            }

            String line;
            while ((line = reader.readLine()) != null) {

                if (line.toLowerCase().contains("exported object may not be a valid 2-manifold"))
                    return false;
                if (!line.startsWith("ECHO:"))
                    System.out.println("OPENSCAD MESSAGE: " + line);
            }
            return true;
        }
    }

    private void waitFor(Process scad) throws InterruptedException {
        if (timeout > 0) {
            if(!scad.waitFor(timeout, TimeUnit.MILLISECONDS)) {
                scad.destroyForcibly();
                throw new RuntimeException("Timeout");
            }
        } else
            scad.waitFor();
    }


    private boolean validateSTL(File scadFile) throws IOException, InterruptedException {
        List<String> command = new ArrayList<>();
        command.add(slic3rPath.toString());
        command.add("--info");
        command.add(scadFile.getAbsolutePath());

//        System.out.println("Starting Slic3r:");
        long now = System.currentTimeMillis();
        Process slic3r = new ProcessBuilder(command).redirectOutput(ProcessBuilder.Redirect.PIPE).start();

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(slic3r.getInputStream()))) {
//            System.out.println("> " + command.stream().collect(Collectors.joining(" ")));

            waitFor(slic3r);
            double time = (System.currentTimeMillis() - now) * 0.001;
//            System.out.printf("Slic3r exited with code %d in %.2fs\n", resp, time);


            if (slic3r.exitValue() != 0) {
                return false;
            }

            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (line.startsWith("size:")) {
                    String dims = line.substring("size:".length()).trim();
                    Pattern pattern = Pattern.compile("x=([^ ]+)\\s+y=([^ ]+)\\s+z=([^ ]+)");
                    Matcher matcher = pattern.matcher(dims);
                    if (!matcher.find()) {
                        System.err.println("Ill-formatted dimensions: " + dims);
                        return false;
                    }
                    double x = Double.parseDouble(matcher.group(1));
                    double y = Double.parseDouble(matcher.group(2));
                    double z = Double.parseDouble(matcher.group(3));

                    if (!isSizeValid(x, y, z))
                        return false;
                } else if (line.startsWith("needed repair:")) {
                    String repair = line.substring("needed repair:".length()).trim();
                    if (!repair.equals("no"))
                        return false;
                } else if (line.startsWith("volume:")) {
                    double volume = Double.parseDouble(line.substring("volume:".length()).trim());
                    if (!isVolumeValid(volume))
                        return false;
                }
            }
        }
        return true;
    }

    private String featureToString(FeatureValue featureValue) {
        return JSONValue.toJSONString(featureValue.getValue());
    }

    @Override
    public Set<FeatureId> features() {
        return model.features();
    }

    @Override
    public FeatureDomain getDomain(FeatureId id) {
        return model.getDomain(id);
    }

    @Override
    public Set<ConstraintId> constraints() {
        return model.constraints();
    }

    @Override
    public VariabilityModel remove(ConstraintId id) {
        throw new RuntimeException("Not implemented");
    }

    @Override
    public Constraint getConstraint(ConstraintId id) {
        return model.getConstraint(id);
    }

    @Override
    public String getName() {
        return model.getName();
    }
}
