// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.dw.roo.conference.domain;

import java.lang.String;

privileged aspect Speaker_Roo_ToString {
    
    public String Speaker.toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Id: ").append(getId()).append(", ");
        sb.append("Version: ").append(getVersion()).append(", ");
        sb.append("Firstname: ").append(getFirstname()).append(", ");
        sb.append("Lastname: ").append(getLastname()).append(", ");
        sb.append("Email: ").append(getEmail()).append(", ");
        sb.append("Password: ").append(getPassword()).append(", ");
        sb.append("Organization: ").append(getOrganization()).append(", ");
        sb.append("Birthdate: ").append(getBirthdate()).append(", ");
        sb.append("Age: ").append(getAge()).append(", ");
        sb.append("Talks: ").append(getTalks() == null ? "null" : getTalks().size());
        return sb.toString();
    }
    
}
