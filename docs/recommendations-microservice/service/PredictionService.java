package com.nextstep.recommendations.service;

import com.nextstep.recommendations.dto.StudentProfileDTO;
import com.nextstep.recommendations.mapper.StudentProfileMapper;
import com.nextstep.recommendations.model.StudentProfile;
import com.nextstep.recommendations.repository.RecommendationRepository;
import com.nextstep.recommendations.utils.Predictor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
public class PredictionService {

    private final RecommendationRepository recommendationRepository;
    private final Predictor predictor;

    @Autowired
    public PredictionService(RecommendationRepository recommendationRepository, Predictor predictor) {
        this.recommendationRepository = recommendationRepository;
        this.predictor = predictor;
    }

    @Transactional
    public StudentProfileDTO updateStudentProfile(UUID userId, StudentProfileDTO studentProfileDTO) throws Exception {
        studentProfileDTO.setId(userId);

        StudentProfile studentProfile = StudentProfileMapper.INSTANCE.toEntity(studentProfileDTO);
        studentProfile = predictor.updateCareerProbabilities(studentProfile);

        recommendationRepository.save(studentProfile);
        return StudentProfileMapper.INSTANCE.toDTO(studentProfile);
    }
}
