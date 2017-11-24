//package be.unamur.mlvm.evaluator;
//
//
//import be.unamur.mlvm.vm.Configuration;
//
//public class SampleConfiguration {
//    private final Configuration configuration;
//    private final boolean isValid;
//
//    public SampleConfiguration(Configuration configuration, boolean isValid) {
//        this.configuration = configuration;
//        this.isValid = isValid;
//    }
//
//    public Configuration getConfiguration() {
//        return configuration;
//    }
//
//    public boolean isValid() {
//        return isValid;
//    }
//
//    @Override
//    public boolean equals(Object o) {
//        if (this == o) return true;
//        if (o == null || getClass() != o.getClass()) return false;
//
//        SampleConfiguration that = (SampleConfiguration) o;
//
//        if (isValid != that.isValid) return false;
//        return configuration != null ? configuration.equals(that.configuration) : that.configuration == null;
//    }
//
//    @Override
//    public int hashCode() {
//        int result = configuration != null ? configuration.hashCode() : 0;
//        result = 31 * result + (isValid ? 1 : 0);
//        return result;
//    }
//}
