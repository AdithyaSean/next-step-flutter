package com.nextstep.users.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "institutions")
public class Institution extends User {
    @Column(nullable = false)
    private String address;

    @Column(nullable = false)
    private String contactPerson;

    @Column(nullable = false)
    private String institutionType;

    public Institution() {
    }

    public String getAddress() {
        return this.address;
    }

    public String getContactPerson() {
        return this.contactPerson;
    }

    public String getInstitutionType() {
        return this.institutionType;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public void setInstitutionType(String institutionType) {
        this.institutionType = institutionType;
    }
}