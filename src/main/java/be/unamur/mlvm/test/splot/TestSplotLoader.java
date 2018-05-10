package be.unamur.mlvm.test.splot;

import be.unamur.mlvm.splot.SplotModelLoader;
import be.unamur.mlvm.vm.*;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * Tests various training algorithms with various models, sampling with the full set and then testing it
 */
public class TestSplotLoader {

    public static void main(String[] args) throws Exception {
        IndexedVariabilityModel model = (IndexedVariabilityModel) loadSampleFile("/SPLOT/model_20131129_1795005487.xml");

        String[][] samples = {
                {"false", "true", "true", "true", "true", "false", "false", "true", "true", "true", "false"},
                {"true", "true", "false", "false", "true", "true", "false", "true", "true", "true", "false"},
                {"true", "true", "true", "false", "true", "false", "false", "false", "true", "true", "false"},
                {"false", "true", "true", "true", "true", "true", "false", "false", "true", "true", "false"},
                {"true", "true", "true", "false", "true", "false", "false", "true", "true", "true", "false"},
                {"false", "true", "true", "true", "true", "false", "false", "false", "true", "true", "false"},
                {"true", "true", "false", "false", "true", "true", "false", "false", "false", "true", "false"},
                {"true", "true", "true", "false", "true", "true", "false", "true", "true", "true", "false"},
                {"true", "true", "true", "false", "true", "true", "false", "false", "true", "true", "false"},
                {"false", "true", "true", "true", "true", "true", "false", "true", "true", "true", "false"},
                {"false", "true", "false", "true", "true", "false", "false", "false", "false", "true", "true"},
                {"false", "true", "false", "false", "true", "true", "true", "true", "true", "true", "true"},
                {"false", "true", "false", "true", "true", "true", "false", "false", "false", "true", "true"},
                {"true", "true", "false", "false", "true", "false", "false", "false", "false", "true", "true"},
                {"false", "true", "false", "false", "true", "true", "true", "false", "false", "true", "true"},
                {"false", "true", "true", "false", "true", "false", "true", "false", "true", "true", "true"},
                {"false", "true", "false", "true", "true", "true", "false", "true", "true", "true", "true"},
                {"false", "true", "true", "false", "true", "true", "true", "false", "true", "true", "true"},
                {"false", "true", "false", "false", "true", "false", "true", "false", "false", "true", "true"},
                {"true", "true", "false", "false", "true", "false", "false", "true", "true", "true", "true"},
                {"false", "true", "false", "true", "true", "false", "false", "true", "true", "true", "true"},
                {"false", "true", "true", "false", "true", "false", "true", "true", "true", "true", "true"},
                {"false", "true", "true", "false", "true", "true", "true", "true", "true", "true", "true"},
                {"false", "true", "false", "false", "true", "false", "true", "true", "true", "true", "true"}
        };


        List<FeatureId> fields = Stream.of("_r_2_5_6", "_r_1", "_r_11_12_14", "_r_2_5_7", "_r_2", "_r_3", "_r_2_5_8", "_r_11_12_13", "_r_11", "_r")
                .map(FeatureId::new)
                .collect(Collectors.toList());

        for (int i1 = 0; i1 < samples.length; i1++) {
            String[] sample = samples[i1];
            Map<FeatureId, FeatureValue> values = new HashMap<>();
            values.put(new FeatureId("_r"), FeatureValue.parse("true"));

            for (int i = 0; i < fields.size(); i++) {
                values.put(fields.get(i), FeatureValue.parse(sample[i]));
            }
            Configuration c = new IndexedConfiguration(model, values);
            if (Boolean.parseBoolean(sample[fields.size()]) && !model.isValid(c)) {
                System.out.println("Error with configuration " + i1);
                model.failures(c).forEach(System.out::println);
                System.out.println();
            }
        }
        System.out.println("Done, no more errors");
    }
    private static VariabilityModel loadSampleFile(String s) throws Exception {
        return loadFile(Paths.get(TestSplotLoader.class.getResource("/samples/" + s).toURI()));
    }

    private static VariabilityModel loadFile(Path x) {
        try {
            return SplotModelLoader.parse(x.toString());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


}
