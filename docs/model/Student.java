package com.nextstep.users.model;

import jakarta.persistence.*;

@Entity
@Table(name = "students")
public class Student extends User {

    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @PrimaryKeyJoinColumn
    private StudentProfile studentProfile;

    @Column(nullable = false)
    private String school;

    @Column(nullable = false)
    private String district;

    public Student(StudentProfile studentProfile, String school, String district) {
        this.studentProfile = studentProfile;
        this.school = school;
        this.district = district;
    }

    public Student() {
    }

    public StudentProfile getStudentProfile() {
        return this.studentProfile;
    }

    public String getSchool() {
        return this.school;
    }

    public String getDistrict() {
        return this.district;
    }

    public void setStudentProfile(StudentProfile studentProfile) {
        this.studentProfile = studentProfile;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    public void setDistrict(String district) {
        this.district = district;
    }
}