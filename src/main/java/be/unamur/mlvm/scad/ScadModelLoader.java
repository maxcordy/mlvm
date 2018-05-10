package be.unamur.mlvm.scad;

import be.unamur.mlvm.vm.*;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.*;
import java.util.List;
import java.util.stream.Collectors;

public class ScadModelLoader {


    public static VariabilityModel load(File file) throws IOException, ParseException {
        JSONParser p = new JSONParser();
        String modelName = file.getParentFile().getName() + '/' + file.getName();

        File json = new File(file.getParentFile(), file.getName().replaceAll("\\.scad$", ".json"));

        IndexedVariabilityModel model = new IndexedVariabilityModel(modelName);

        try (Reader reader = new FileReader(json)) {
            Object obj = p.parse(reader);

            if (!(obj instanceof JSONObject))
                throw new IOException("Invalid JSON file: " + file);

            JSONObject params = (JSONObject) obj;
            params.forEach((key, value) -> model.addFeature(new FeatureId(key.toString()), parseFeature(value)));
        }
        return model;
    }

    private static FeatureDomain parseFeature(Object value) {
        if (!(value instanceof JSONObject))
            throw new RuntimeException("Invalid JSON type: " + value);
        JSONObject typeObj = (JSONObject) value;

        String type = typeObj.get("type").toString();
        switch (type) {
            case "float":
                return new FeatureDomain.Numeric();

            case "range":
                double min = ((Number) typeObj.get("start")).doubleValue();
                double max = ((Number) typeObj.get("end")).doubleValue();
                return new FeatureDomain.Numeric(min, max);

            case "enum":
                List<String> values1 = ((List<String>) typeObj.get("values")).stream()
                        .map(String::trim).collect(Collectors.toList());
                FeatureValue[] values;
                if (values1.stream().allMatch(ScadModelLoader::isFloat))
                    values = values1.stream().mapToDouble(Double::parseDouble)
                            .mapToObj(FeatureValue::new).toArray(FeatureValue[]::new);
                else
                    values = values1.stream().map(FeatureValue::new).toArray(FeatureValue[]::new);

                return new FeatureDomain.Nominal(values);


            case "custom":
            case "string":
            case "mixed":
            case "array":
                throw new UnhandledTypeException(typeObj.toJSONString());

            default:
                throw new RuntimeException("Unknown type: " + ((JSONObject) value).toJSONString());
        }
    }

    private static boolean isFloat(String x) {
        try {
            Double.valueOf(x);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }


    public static class UnhandledTypeException extends RuntimeException {
        public UnhandledTypeException(String s) {
            super(s);
        }
    }
}
