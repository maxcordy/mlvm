package be.unamur.bamand.openscad;

import java.util.Optional;
import java.util.function.Function;
import java.util.function.Predicate;

/**
 * Created by Benoit Amand on 13-07-16.
 */
@FunctionalInterface
public interface Matcher<T, U> {

    default Matcher<T, U> orWhen(Predicate<T> cond, Function<T, U> operation) {
        return t -> {
            Optional<U> opt = this.match(t);

            if (opt.isPresent() || !cond.test(t))
                return opt;
            return Optional.of(operation.apply(t));
        };
    }

    static <T,U> Matcher<T, U> when(Predicate<T> cond, Function<T, U> operation) {
        return t -> Optional.of(t).filter(cond).map(operation);
    }
//
//    default <H extends T> Matcher<T, U> with(Class<H> clazz, Function<H, U> operation) {
//        return t -> {
//            Optional<U> opt = this.match(t);
//            if (opt.isPresent() || !clazz.isInstance(t))
//                return opt;
//            return Optional.of(operation.apply((H) t));
//        };
//    }

    Optional<U> match(T t);
}

















