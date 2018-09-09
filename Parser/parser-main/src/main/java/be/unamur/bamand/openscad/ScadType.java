package be.unamur.bamand.openscad;

import org.json.simple.JSONObject;

public class ScadType {

    public static final ScadType Mixed = new ScadType(Type.Mixed);
    public static final ScadType Bool = new ScadType(Type.Bool);
    public static final ScadType Float = new ScadType(Type.Float);
    public static final ScadType String = new ScadType(Type.String);
    public static final ScadType Undef = new ScadType(Type.Undef);

    enum Type {Float, Bool, Mixed, String, Array, Undef}

    private Type type;
    private ScadType items;

    public ScadType(Type type) {
        this.type = type;
    }

    public ScadType(Type type, ScadType items) {
        this.type = type;
        this.items = items;
    }

    public ScadType unionWith(ScadType b) {
        if (b.type != type)
            return Mixed;

        if (type == Type.Array)
            return new ScadType(type, items.unionWith(b.items));
        return this;
    }

    public JSONObject toJSON() {
        JSONObject obj = new JSONObject();
        obj.put("type", type.toString().toLowerCase());
        if (type == Type.Array)
            obj.put("items", items.toJSON());
        return obj;
    }
}


