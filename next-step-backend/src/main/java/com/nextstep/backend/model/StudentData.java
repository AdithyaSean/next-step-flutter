package com.nextstep.backend.model;

import java.util.Map;
import java.util.HashMap;

public class StudentData {
    private Map<String, Double> features;

    public StudentData() {
        this.features = new HashMap<>();
    }

    public void setFeature(String name, Double value) {
        features.put(name, value);
    }

    public Double getFeatureValue(String name) {
        return features.getOrDefault(name, 0.0);
    }

    // Getters and setters for specific fields
    public void setDistrict(int district) {
        features.put("district", (double) district);
    }

    public void setFinancialConstraints(int constraints) {
        features.put("financial_constraints", (double) constraints);
    }

    public void setEducationLevel(int level) {
        features.put("education_level", (double) level);
    }

    public void setOLResult(String subject, String grade) {
        double value = convertGradeToNumeric(grade);
        features.put("ol_" + subject.toLowerCase(), value);
    }

    public void setALResult(String subject, String grade) {
        double value = convertGradeToNumeric(grade);
        features.put("al_" + subject.toLowerCase(), value);
    }

    public void setStream(int stream) {
        features.put("stream", (double) stream);
    }

    public void setZScore(double zscore) {
        features.put("zscore", zscore);
    }

    public void setInterest(int index, boolean hasInterest) {
        features.put("interest_" + index, hasInterest ? 1.0 : 0.0);
    }

    public void setCurrentGPA(double gpa) {
        features.put("current_gpa", gpa);
    }

    private double convertGradeToNumeric(String grade) {
        return switch (grade.toUpperCase()) {
            case "A" -> 4.0;
            case "B" -> 3.0;
            case "C" -> 2.0;
            case "S" -> 1.0;
            case "F" -> 0.0;
            default -> 0.0;
        };
    }
}
