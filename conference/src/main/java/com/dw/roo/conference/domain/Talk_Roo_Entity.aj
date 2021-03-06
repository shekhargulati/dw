// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.dw.roo.conference.domain;

import com.dw.roo.conference.domain.Talk;
import java.lang.Integer;
import java.lang.Long;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PersistenceContext;
import javax.persistence.Version;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Talk_Roo_Entity {
    
    declare @type: Talk: @Entity;
    
    @PersistenceContext
    transient EntityManager Talk.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long Talk.id;
    
    @Version
    @Column(name = "version")
    private Integer Talk.version;
    
    public Long Talk.getId() {
        return this.id;
    }
    
    public void Talk.setId(Long id) {
        this.id = id;
    }
    
    public Integer Talk.getVersion() {
        return this.version;
    }
    
    public void Talk.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void Talk.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Talk.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Talk attached = this.entityManager.find(this.getClass(), this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Talk.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public Talk Talk.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Talk merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
    public static final EntityManager Talk.entityManager() {
        EntityManager em = new Talk().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Talk.countTalks() {
        return entityManager().createQuery("select count(o) from Talk o", Long.class).getSingleResult();
    }
    
    public static List<Talk> Talk.findAllTalks() {
        return entityManager().createQuery("select o from Talk o", Talk.class).getResultList();
    }
    
    public static Talk Talk.findTalk(Long id) {
        if (id == null) return null;
        return entityManager().find(Talk.class, id);
    }
    
    public static List<Talk> Talk.findTalkEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("select o from Talk o", Talk.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}
