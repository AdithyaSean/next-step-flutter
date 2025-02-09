package com.nextstep.recommendations.repository;

import com.nextstep.recommendations.model.StudentProfile;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.UUID;

@Repository
public interface RecommendationRepository extends JpaRepository<StudentProfile, UUID> {
}
