package bio.ferlab.keycloak.authenticators.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class UserOptionsModel {
    public List<OptionsModel> roleOptions = new ArrayList<>();
    public List<OptionsModel> researchDomainOptions = new ArrayList<>();
    public List<OptionsModel> usageOptions = new ArrayList<>();

    public Map asMap(){
        Map result = new HashMap();
        result.put("roleOptions", this.roleOptions.stream().map(OptionsModel::asMap).collect(Collectors.toList()));
        result.put("researchDomainOptions", this.researchDomainOptions.stream().map(OptionsModel::asMap).collect(Collectors.toList()));
        result.put("usageOptions", this.usageOptions.stream().map(OptionsModel::asMap).collect(Collectors.toList()));
        return result;
    }
}

