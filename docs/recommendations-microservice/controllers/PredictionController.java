package com.nextstep.recommendations.controllers;

import com.nextstep.recommendations.dto.StudentProfileDTO;
import com.nextstep.recommendations.service.PredictionService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/predictions")
public class PredictionController {

    private final PredictionService predictionService;

    @Autowired
    public PredictionController(PredictionService predictionService) {
        this.predictionService = predictionService;
    }

    @PostMapping("/career-prediction")
    public ResponseEntity<StudentProfileDTO> updateStudentProfile(@RequestHeader("UUID") UUID userId, @Valid @RequestBody StudentProfileDTO studentProfileDTO) throws Exception {
        return ResponseEntity.ok(predictionService.updateStudentProfile(userId, studentProfileDTO));
    }
}