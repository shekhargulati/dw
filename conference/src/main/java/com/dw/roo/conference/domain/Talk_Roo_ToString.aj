// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.dw.roo.conference.domain;

import java.lang.String;

privileged aspect Talk_Roo_ToString {
    
    public String Talk.toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Id: ").append(getId()).append(", ");
        sb.append("Version: ").append(getVersion()).append(", ");
        sb.append("Title: ").append(getTitle()).append(", ");
        sb.append("Description: ").append(getDescription()).append(", ");
        sb.append("Speaker: ").append(getSpeaker());
        return sb.toString();
    }
    
}