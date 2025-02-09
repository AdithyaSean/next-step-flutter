package com.nextstep.recommendations.mapper;

import com.nextstep.recommendations.dto.StudentProfileDTO;
import com.nextstep.recommendations.model.StudentProfile;

public class StudentProfileMapper {

    public static final StudentProfileMapper INSTANCE = new StudentProfileMapper();

    private StudentProfileMapper() {}

    public StudentProfile toEntity(StudentProfileDTO studentProfileDTO) {
        if (studentProfileDTO == null) {
            return null;
        }

        StudentProfile studentProfile = new StudentProfile();
        studentProfile.setId(studentProfileDTO.getId());
        studentProfile.setEducationLevel(studentProfileDTO.getEducationLevel());
        studentProfile.setOlResults(studentProfileDTO.getOlResults());
        studentProfile.setAlStream(studentProfileDTO.getAlStream());
        studentProfile.setAlResults(studentProfileDTO.getAlResults());
        studentProfile.setCareerProbabilities(studentProfileDTO.getCareerProbabilities());
        studentProfile.setGpa(studentProfileDTO.getGpa());

        return studentProfile;
    }

    public StudentProfileDTO toDTO(StudentProfile studentProfile) {
        if (studentProfile == null) {
            return null;
        }

        StudentProfileDTO studentProfileDTO = new StudentProfileDTO();
        studentProfileDTO.setId(studentProfile.getId());
        studentProfileDTO.setEducationLevel(studentProfile.getEducationLevel());
        studentProfileDTO.setOlResults(studentProfile.getOlResults());
        studentProfileDTO.setAlStream(studentProfile.getAlStream());
        studentProfileDTO.setAlResults(studentProfile.getAlResults());
        studentProfileDTO.setCareerProbabilities(studentProfile.getCareerProbabilities());
        studentProfileDTO.setGpa(studentProfile.getGpa());

        return studentProfileDTO;
    }
}