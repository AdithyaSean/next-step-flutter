package com.nextstep.users.controller;

import com.nextstep.users.dto.StudentDTO;
import com.nextstep.users.dto.StudentProfileDTO;
import com.nextstep.users.dto.UserDTO;
import com.nextstep.users.service.StudentService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/students")
public class StudentController {

    private final StudentService studentService;

    @Autowired
    public StudentController(StudentService studentService) {
        this.studentService = studentService;
    }

    @GetMapping
    public ResponseEntity<List<StudentDTO>> getAllStudents() {
        return ResponseEntity.ok(studentService.getAllStudents());
    }

    @PostMapping
    public ResponseEntity<UserDTO> registerStudent(@Valid @RequestBody StudentDTO studentDTO) {
        return ResponseEntity.status(HttpStatus.CREATED).body(studentService.createStudent(studentDTO));
    }

    @PutMapping("/profile")
    public ResponseEntity<StudentProfileDTO> updateStudentProfile(@RequestHeader("UUID") UUID id, @Valid @RequestBody StudentProfileDTO studentProfileDTO) {
        return ResponseEntity.ok(studentService.updateStudentProfile(id, studentProfileDTO));
    }

    @GetMapping("/profile")
    public ResponseEntity<StudentProfileDTO> getStudentProfile(@RequestHeader("UUID") UUID id) {
        return ResponseEntity.ok(studentService.getStudentProfile(id));
    }
}