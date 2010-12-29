package com.dw.roo.conference.domain;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;
import javax.validation.constraints.NotNull;
import javax.persistence.Column;
import java.util.Date;
import javax.validation.constraints.Past;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.springframework.format.annotation.DateTimeFormat;
import javax.validation.constraints.Min;
import javax.validation.constraints.Max;
import java.util.Set;
import com.dw.roo.conference.domain.Talk;
import java.util.HashSet;
import javax.persistence.OneToMany;
import javax.persistence.CascadeType;

@RooJavaBean
@RooToString
@RooEntity(finders = { "findSpeakersByEmailAndPasswordEquals" })
public class Speaker {

    @NotNull
    private String firstname;

    @NotNull
    private String lastname;

    @NotNull
    @Column(unique = true)
    private String email;

    @NotNull
    private String password;

    private String organization;

    @NotNull
    @Past
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(style = "S-")
    private Date birthdate;

    @Min(25L)
    @Max(60L)
    private Long age;

    @OneToMany(cascade = CascadeType.ALL)
    private Set<Talk> talks = new HashSet<Talk>();
}
