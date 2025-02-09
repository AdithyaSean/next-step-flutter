package com.nextstep.users.dto;

import jakarta.validation.constraints.NotBlank;

public class InstitutionDTO extends UserDTO {
    @NotBlank(message = "Address is mandatory for institutions")
    private String address;

    @NotBlank(message = "Contact person is mandatory for institutions")
    private String contactPerson;

    @NotBlank(message = "Institution type is mandatory for institutions")
    private String institutionType;

    public InstitutionDTO() {
    }

    public @NotBlank(message = "Address is mandatory for institutions") String getAddress() {
        return this.address;
    }

    public @NotBlank(message = "Contact person is mandatory for institutions") String getContactPerson() {
        return this.contactPerson;
    }

    public @NotBlank(message = "Institution type is mandatory for institutions") String getInstitutionType() {
        return this.institutionType;
    }

    public void setAddress(@NotBlank(message = "Address is mandatory for institutions") String address) {
        this.address = address;
    }

    public void setContactPerson(@NotBlank(message = "Contact person is mandatory for institutions") String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public void setInstitutionType(@NotBlank(message = "Institution type is mandatory for institutions") String institutionType) {
        this.institutionType = institutionType;
    }
}