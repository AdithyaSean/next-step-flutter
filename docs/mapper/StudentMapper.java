package com.nextstep.users.mapper;

import com.nextstep.users.dto.StudentDTO;
import com.nextstep.users.dto.StudentProfileDTO;
import com.nextstep.users.model.Student;
import com.nextstep.users.model.StudentProfile;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface StudentMapper {
    StudentMapper INSTANCE = Mappers.getMapper(StudentMapper.class);

    StudentDTO studentToStudentDTO(Student student);

    Student studentDTOToStudent(StudentDTO studentDTO);

    StudentProfileDTO studentProfileToStudentProfileDTO(StudentProfile studentProfile);

    StudentProfile studentProfileDTOToStudentProfile(StudentProfileDTO studentProfileDTO);
}
