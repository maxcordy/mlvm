package be.unamur.mlvm.test.splot;

import be.unamur.mlvm.splot.SplotModelLoader;
import be.unamur.mlvm.vm.VariabilityModel;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.stream.Stream;

public class SplotUtils {


    public static Stream<VariabilityModel> loadSamplesDirectory(String s) throws Exception {
        return Files.list(Paths.get(SplotUtils.class.getResource("/samples/" + s).toURI()))
                .map(SplotUtils::loadFile);
    }

    public static VariabilityModel loadFile(Path x) {
        try {
            return SplotModelLoader.parse(x.toString());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
