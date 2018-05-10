package be.unamur.mlvm.test.splot;

import be.unamur.mlvm.vm.ConstraintId;
import be.unamur.mlvm.vm.VariabilityModel;

import java.util.*;

@FunctionalInterface
public interface ConstraintRemover {
    List<ConstraintId> pickForRemoval(VariabilityModel model);


    static ConstraintRemover takeN(int n) {
        return x -> {
            Iterator<ConstraintId> iterator = x.constraints().iterator();
            ArrayList<ConstraintId> list = new ArrayList<>();
            while(iterator.hasNext() && list.size() < n)
                list.add(iterator.next());
            return Collections.emptyList();
        };
    }
}
