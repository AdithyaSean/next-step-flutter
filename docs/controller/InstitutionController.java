package com.nextstep.users.controller;

import com.nextstep.users.dto.InstitutionDTO;
import com.nextstep.users.dto.UserDTO;
import com.nextstep.users.service.InstitutionService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/institutions")
public class InstitutionController {

    private final InstitutionService institutionService;

    @Autowired
    public InstitutionController(InstitutionService institutionService) {
        this.institutionService = institutionService;
    }

    @PostMapping("/register")
    public ResponseEntity<UserDTO> registerInstitution(@Valid @RequestBody InstitutionDTO institutionDTO) {
        return new ResponseEntity<>(institutionService.createInstitution(institutionDTO), HttpStatus.CREATED);
    }
}
