package bio.ferlab.keycloak.authenticators.model;

import java.time.LocalDateTime;
import java.util.List;

public class UserProfileModel {

    private String id;
    private String first_name;
    private String last_name;
    private String era_commons_id;
    private String nih_ned_id;
    private String email;
    private String external_individual_fullname;
    private String external_individual_email;
    private List<String> roles;
    private String affiliation;
    private List<String> portal_usages;
    private List<String> research_areas;
    private String research_area_description;
    private boolean accepted_terms;
    private boolean understand_disclaimer;
    private String commercial_use_reason;
    private boolean completed_registration;
    private LocalDateTime consent_date;

    public UserProfileModel() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getEra_commons_id() {
        return era_commons_id;
    }

    public void setEra_commons_id(String era_commons_id) {
        this.era_commons_id = era_commons_id;
    }

    public String getNih_ned_id() {
        return nih_ned_id;
    }

    public void setNih_ned_id(String nih_ned_id) {
        this.nih_ned_id = nih_ned_id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getExternal_individual_fullname() {
        return external_individual_fullname;
    }

    public void setExternal_individual_fullname(String external_individual_fullname) {
        this.external_individual_fullname = external_individual_fullname;
    }

    public String getExternal_individual_email() {
        return external_individual_email;
    }

    public void setExternal_individual_email(String external_individual_email) {
        this.external_individual_email = external_individual_email;
    }

    public List<String> getRoles() {
        return roles;
    }

    public void setRoles(List<String> roles) {
        this.roles = roles;
    }

    public String getAffiliation() {
        return affiliation;
    }

    public void setAffiliation(String affiliation) {
        this.affiliation = affiliation;
    }

    public List<String> getPortal_usages() {
        return portal_usages;
    }

    public void setPortal_usages(List<String> portal_usages) {
        this.portal_usages = portal_usages;
    }

    public List<String> getResearch_areas() {
        return research_areas;
    }

    public void setResearch_areas(List<String> research_areas) {
        this.research_areas = research_areas;
    }

    public String getResearch_area_description() {
        return research_area_description;
    }

    public void setResearch_area_description(String research_area_description) {
        this.research_area_description = research_area_description;
    }


    public boolean isAccepted_terms() {
        return accepted_terms;
    }

    public boolean isUnderstand_disclaimer() {
        return understand_disclaimer;
    }

    public void setUnderstand_disclaimer(boolean understand_disclaimer) {
        this.understand_disclaimer = understand_disclaimer;
    }

    public String getCommercial_use_reason() {
        return commercial_use_reason;
    }

    public void setCommercial_use_reason(String commercial_use_reason) {
        this.commercial_use_reason = commercial_use_reason;
    }

    public boolean isCompleted_registration() {
        return completed_registration;
    }

    public void setCompleted_registration(boolean completed_registration) {
        this.completed_registration = completed_registration;
    }

    public void setAccepted_terms(boolean accepted_terms) {
        this.accepted_terms = accepted_terms;
    }

    public LocalDateTime getConsent_date() {
        return consent_date;
    }

    public void setConsent_date(LocalDateTime consent_date) {
        this.consent_date = consent_date;
    }
}
