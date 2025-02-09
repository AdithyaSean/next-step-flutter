package com.nextstep.recommendations.dto;

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

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public int getEducationLevel() {
        return educationLevel;
    }

    public void setEducationLevel(int educationLevel) {
        this.educationLevel = educationLevel;
    }

    public Map<String, Double> getOlResults() {
        return olResults;
    }

    public void setOlResults(Map<String, Double> olResults) {
        this.olResults = olResults;
    }

    public Integer getAlStream() {
        return alStream;
    }

    public void setAlStream(Integer alStream) {
        this.alStream = alStream;
    }

    public Map<String, Double> getAlResults() {
        return alResults;
    }

    public void setAlResults(Map<String, Double> alResults) {
        this.alResults = alResults;
    }

    public Map<String, Double> getCareerProbabilities() {
        return careerProbabilities;
    }

    public void setCareerProbabilities(Map<String, Double> careerProbabilities) {
        this.careerProbabilities = careerProbabilities;
    }

    public Double getGpa() {
        return gpa;
    }

    public void setGpa(Double gpa) {
        this.gpa = gpa;
    }
}