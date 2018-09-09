package be.unamur.bamand.openscad;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.*;
import java.util.stream.Collectors;

public class JsonExporter {
    public static void main(String args[]) {

        JSONParser parser = new JSONParser();
        try (Reader reader = args.length < 1 ? new InputStreamReader(System.in) : new FileReader(args[0]);
             Writer writer = args.length < 2 ? new OutputStreamWriter(System.out) : new FileWriter(args[1])) {
            JSONArray output = toJSON(parser, reader);
            writer.write(output.toJSONString());
            writer.flush();
        } catch (IOException | ParseException e) {
            e.printStackTrace();
            System.exit(1);
        }
    }

    private static JSONArray toJSON(JSONParser parser, Reader reader) throws IOException, ParseException {
        JSONObject c = (JSONObject) parser.parse(reader);
        String content = (String) c.get("content");
        String filename = (String) c.get("filename");
        ScadAnalyzer analyzer = new ScadAnalyzer(filename, content);

        return analyzer.getParameters().stream().map(param -> {
            JSONObject obj = new JSONObject();
            obj.put("name", param.getName());
            obj.put("location", param.getLocation().toString());

            if (param.getSection() != null) obj.put("section", param.getSection());
            if (param.getDescription() != null) obj.put("description", param.getDescription());
            if (param.getConstraints() != null) obj.put("values", param.getConstraints());
            if (param.getDefault() != null) obj.put("default", param.getDefault());
            if (param.getDefaultType() != null) obj.put("defaultType", param.getDefaultType().toJSON());
            return obj;
        }).collect(Collectors.toCollection(JSONArray::new));
    }
}
