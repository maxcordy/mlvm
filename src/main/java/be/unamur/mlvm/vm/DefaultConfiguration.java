//package be.unamur.mlvm.vm;
//
//        import java.util.HashMap;
//        import java.util.List;
//        import java.util.Map;
//        import java.util.stream.Collectors;
//        import java.util.stream.IntStream;
//
//public class DefaultConfiguration implements Configuration {
//    private final Map<FeatureId, FeatureValue> values;
//
//    public DefaultConfiguration(Map<FeatureId, FeatureValue> values) {
//        this.values = values;
//    }
//
//    @Override
//    public FeatureValue valueOf(FeatureId id) {
//        return values.get(id);
//    }
//}
