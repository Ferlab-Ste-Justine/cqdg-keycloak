package bio.ferlab.keycloak.authenticators.model;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class OptionsModel implements Serializable {
    public String label;
    public String value;

    public OptionsModel(String label, String alias, String value) {
        this.label = label + " (" + alias + ")";
        this.value = value;
    }

    public Map asMap(){
        Map result = new HashMap();
        result.put("label", this.label);
        result.put("value", this.value);
        return result;
    }
}