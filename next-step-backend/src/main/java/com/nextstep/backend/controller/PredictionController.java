package com.nextstep.backend.controller;

import com.nextstep.backend.model.StudentData;
import com.nextstep.backend.service.CareerPredictionService;
import com.nextstep.backend.service.CareerPredictionService.CareerPrediction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/predictions")
public class PredictionController {

    @Autowired
    private CareerPredictionService predictionService;

    @PostMapping("/career-paths")
    public ResponseEntity<List<CareerPrediction>> predictCareerPaths(@RequestBody StudentData student) {
        try {
            List<CareerPrediction> predictions = predictionService.predictCareerPaths(student);
            return ResponseEntity.ok(predictions);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
