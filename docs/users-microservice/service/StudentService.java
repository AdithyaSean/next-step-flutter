package com.nextstep.users.service;

import com.nextstep.users.dto.StudentDTO;
import com.nextstep.users.dto.StudentProfileDTO;
import com.nextstep.users.mapper.StudentMapper;
import com.nextstep.users.model.Student;
import com.nextstep.users.model.StudentProfile;
import com.nextstep.users.repository.UserRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class StudentService {

    private final UserRepository userRepository;
    private final StudentMapper studentMapper = StudentMapper.INSTANCE;
    private final RestTemplate restTemplate;

    @Value("${next-step-recommendations.url}")
    private String nextStepRecommendationsUrl;

    public StudentService(UserRepository userRepository, RestTemplate restTemplate) {
        this.userRepository = userRepository;
        this.restTemplate = restTemplate;
    }

    @Transactional
    public StudentDTO createStudent(StudentDTO studentDTO) {
        return studentMapper.studentToStudentDTO(userRepository.save(studentMapper.studentDTOToStudent(studentDTO)));
    }

    @Transactional(readOnly = true)
    public List<StudentDTO> getAllStudents() {
        return userRepository.findAll().stream()
                .filter(user -> user instanceof Student)
                .map(user -> {
                    StudentDTO studentDTO = studentMapper.studentToStudentDTO((Student) user);
                    studentDTO.setStudentProfile(studentMapper.studentProfileToStudentProfileDTO(((Student) user).getStudentProfile()));
                    return studentDTO;
                })
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public StudentProfileDTO getStudentProfile(UUID studentId) {
        Student student = (Student) userRepository.findById(studentId).orElseThrow(() -> new RuntimeException("Student not found"));
        return studentMapper.studentProfileToStudentProfileDTO(student.getStudentProfile());
    }

    @Transactional
    public StudentProfileDTO updateStudentProfile(UUID studentId, StudentProfileDTO updatedProfileDTO) {
        Student student = (Student) userRepository.findById(studentId).orElseThrow(() -> new RuntimeException("Student not found"));
        StudentProfile studentProfile = student.getStudentProfile();

        HttpHeaders headers = new HttpHeaders();
        headers.set("UUID", studentId.toString());

        HttpEntity<StudentProfileDTO> requestEntity = new HttpEntity<>(updatedProfileDTO, headers);

        String predictionServiceUrl = nextStepRecommendationsUrl + "/predictions/career-prediction";
        StudentProfileDTO updatedProfileWithProbabilities = restTemplate.postForObject(predictionServiceUrl, requestEntity, StudentProfileDTO.class);
        assert updatedProfileWithProbabilities != null;

        student.setStudentProfile(studentMapper.studentProfileDTOToStudentProfile(updatedProfileWithProbabilities));

        userRepository.save(student);

        return studentMapper.studentProfileToStudentProfileDTO(studentProfile);
    }
}