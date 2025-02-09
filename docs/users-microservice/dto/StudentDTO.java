package com.nextstep.users.dto;

import jakarta.validation.constraints.NotBlank;

public class StudentDTO extends UserDTO {
    @NotBlank(message = "School is mandatory for students")
    private String school;

    @NotBlank(message = "District is mandatory for students")
    private String district;

    private StudentProfileDTO studentProfile;

    public StudentDTO() {
    }

    public @NotBlank(message = "School is mandatory for students") String getSchool() {
        return this.school;
    }

    public @NotBlank(message = "District is mandatory for students") String getDistrict() {
        return this.district;
    }

    public StudentProfileDTO getStudentProfile() {
        return this.studentProfile;
    }

    public void setSchool(@NotBlank(message = "School is mandatory for students") String school) {
        this.school = school;
    }

    public void setDistrict(@NotBlank(message = "District is mandatory for students") String district) {
        this.district = district;
    }

    public void setStudentProfile(StudentProfileDTO studentProfile) {
        this.studentProfile = studentProfile;
    }
}