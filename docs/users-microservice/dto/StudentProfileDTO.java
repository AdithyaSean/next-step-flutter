package com.nextstep.users.dto;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.UUID;

public class StudentProfileDTO {
    private UUID id;
    private int educationLevel;
    private Map<String, Double> olResults;
    private Integer alStream;
    private Map<String, Double> alResults;
    private Map<String, Double> careerProbabilities;
    private Double gpa;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public StudentProfileDTO() {
    }

    public UUID getId() {
        return this.id;
    }

    public int getEducationLevel() {
        return this.educationLevel;
    }

    public Map<String, Double> getOlResults() {
        return this.olResults;
    }

    public Integer getAlStream() {
        return this.alStream;
    }

    public Map<String, Double> getAlResults() {
        return this.alResults;
    }

    public Map<String, Double> getCareerProbabilities() {
        return this.careerProbabilities;
    }

    public Double getGpa() {
        return this.gpa;
    }

    public LocalDateTime getCreatedAt() {
        return this.createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return this.updatedAt;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public void setEducationLevel(int educationLevel) {
        this.educationLevel = educationLevel;
    }

    public void setOlResults(Map<String, Double> olResults) {
        this.olResults = olResults;
    }

    public void setAlStream(Integer alStream) {
        this.alStream = alStream;
    }

    public void setAlResults(Map<String, Double> alResults) {
        this.alResults = alResults;
    }

    public void setCareerProbabilities(Map<String, Double> careerProbabilities) {
        this.careerProbabilities = careerProbabilities;
    }

    public void setGpa(Double gpa) {
        this.gpa = gpa;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}