package be.unamur.bamand.openscad;

import java.util.Optional;
import java.util.function.Consumer;
import java.util.function.Function;

@FunctionalInterface
public interface Mapper<T, U> {

    default <H extends T> Mapper<T, U> with(Class<H> clazz, Function<H, U> operation) {
        return t -> {
            Optional<U> opt = this.visit(t);
            if (opt.isPresent() || !clazz.isInstance(t))
                return opt;
            try {
                return Optional.of(operation.apply((H) t));
            }catch(Exception e) {
                throw new RuntimeException("Error in mapper of " + clazz, e);
            }
        };
    }

    Optional<U> visit(T t);


    static <T, U> Mapper<T, U> create() {
        return t -> Optional.empty();
    }
}



