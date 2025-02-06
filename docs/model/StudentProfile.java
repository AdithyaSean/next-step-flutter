package com.nextstep.users.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.UUID;

@Entity
@Table(name = "student_profiles")
public class StudentProfile {
    @Id
    private UUID id;

    @Column(name = "education_level")
    private int educationLevel;

    @ElementCollection
    @CollectionTable(name = "ol_results", joinColumns = @JoinColumn(name = "profile_id"))
    @MapKeyColumn(name = "subject")
    @Column(name = "grade")
    private Map<String, Double> olResults;

    @Column(name = "al_stream")
    private Integer alStream;

    @ElementCollection
    @CollectionTable(name = "al_results", joinColumns = @JoinColumn(name = "profile_id"))
    @MapKeyColumn(name = "subject")
    @Column(name = "grade")
    private Map<String, Double> alResults;

    @ElementCollection
    @CollectionTable(name = "career_probabilities", joinColumns = @JoinColumn(name = "profile_id"))
    @MapKeyColumn(name = "career")
    @Column(name = "probability")
    private Map<String, Double> careerProbabilities;

    @Column(name = "gpa")
    private Double gpa;

    @Column(name = "created_at", nullable = false, updatable = false)
    private java.time.LocalDateTime createdAt;

    @Column(name = "updated_at")
    private java.time.LocalDateTime updatedAt;

    public StudentProfile() {
    }

    @PrePersist
    protected void onCreate() {
        createdAt = java.time.LocalDateTime.now();
        updatedAt = createdAt;
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = java.time.LocalDateTime.now();
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