package com.nextstep.recommendations.src;

import java.util.HashMap;
import java.util.Map;
import java.util.List;

public class Config {
    // Constants for factor identification in compatibility bonuses
    public static final int Z_SCORE_FACTOR = -1;
    public static final int GPA_FACTOR = -2;

    // Education levels
    public static final Map<String, Integer> EDUCATION_LEVELS = new HashMap<>();
    static {
        EDUCATION_LEVELS.put("OL", 0);  // Ordinary Level
        EDUCATION_LEVELS.put("AL", 1);  // Advanced Level
        EDUCATION_LEVELS.put("UNI", 2); // University
    }

    // Grade mappings
    public static final Map<String, Integer> GRADES = new HashMap<>();
    static {
        GRADES.put("A", 0);
        GRADES.put("B", 1);
        GRADES.put("C", 2);
        GRADES.put("S", 3);
        GRADES.put("F", 4);
    }

    // OL Subjects
    public static final Map<String, Integer> OL_SUBJECTS = new HashMap<>();
    static {
        OL_SUBJECTS.put("Maths", 0);
        OL_SUBJECTS.put("Science", 1);
        OL_SUBJECTS.put("English", 2);
        OL_SUBJECTS.put("Sinhala", 3);
        OL_SUBJECTS.put("History", 4);
        OL_SUBJECTS.put("Religion", 5);
    }

    // AL Streams (corrected to reflect common academic tracks)
    public static final Map<String, Integer> AL_STREAMS = new HashMap<>();
    static {
        AL_STREAMS.put("Physical Science", 6);          // Core science track
        AL_STREAMS.put("Biological Science", 7);        // Life sciences track
        AL_STREAMS.put("Physical Science with ICT", 8); // Tech-oriented science
        AL_STREAMS.put("Bio Science with Agriculture", 9); // Agricultural focus
    }

    // AL Subjects (expanded with missing subjects, unique IDs)
    public static final Map<String, Integer> AL_SUBJECTS = new HashMap<>();
    static {
        AL_SUBJECTS.put("Physics", 10);
        AL_SUBJECTS.put("Chemistry", 11);
        AL_SUBJECTS.put("Combined_Maths", 12);
        AL_SUBJECTS.put("Biology", 13);
        AL_SUBJECTS.put("ICT", 14);
        AL_SUBJECTS.put("Agriculture", 15);
        AL_SUBJECTS.put("Economics", 16);
        AL_SUBJECTS.put("Business_Studies", 17);
    }

    // Education level distribution (adjusted for realism)
    public static final Map<Integer, Double> EDUCATION_LEVEL_DIST = new HashMap<>();
    static {
        EDUCATION_LEVEL_DIST.put(EDUCATION_LEVELS.get("OL"), 0.55);  // 55% reach OL
        EDUCATION_LEVEL_DIST.put(EDUCATION_LEVELS.get("AL"), 0.35);  // 35% reach AL
        EDUCATION_LEVEL_DIST.put(EDUCATION_LEVELS.get("UNI"), 0.10); // 10% reach University
    }

    // AL Subjects by Stream (corrected combinations)
    public static final Map<Integer, List<Integer>> AL_SUBJECTS_BY_STREAM = new HashMap<>();
    static {
        // Physical Science core subjects
        AL_SUBJECTS_BY_STREAM.put(AL_STREAMS.get("Physical Science"), List.of(
                AL_SUBJECTS.get("Combined_Maths"),
                AL_SUBJECTS.get("Physics"),
                AL_SUBJECTS.get("Chemistry")
        ));

        // Physical Science with ICT substitution
        AL_SUBJECTS_BY_STREAM.put(AL_STREAMS.get("Physical Science with ICT"), List.of(
                AL_SUBJECTS.get("Combined_Maths"),
                AL_SUBJECTS.get("Physics"),
                AL_SUBJECTS.get("ICT")
        ));

        // Biological Science core subjects
        AL_SUBJECTS_BY_STREAM.put(AL_STREAMS.get("Biological Science"), List.of(
                AL_SUBJECTS.get("Biology"),
                AL_SUBJECTS.get("Chemistry"),
                AL_SUBJECTS.get("Physics")
        ));

        // Biological Science with Agriculture focus
        AL_SUBJECTS_BY_STREAM.put(AL_STREAMS.get("Bio Science with Agriculture"), List.of(
                AL_SUBJECTS.get("Biology"),
                AL_SUBJECTS.get("Chemistry"),
                AL_SUBJECTS.get("Agriculture")
        ));
    }

    // AL Stream Mapping
    public static final Map<Integer, String> STREAM_NAMES = new HashMap<>();
    static {
        STREAM_NAMES.put(AL_STREAMS.get("Physical Science"), "physical_science");
        STREAM_NAMES.put(AL_STREAMS.get("Biological Science"), "biological_science");
        STREAM_NAMES.put(AL_STREAMS.get("Physical Science with ICT"), "physical_science_ict");
        STREAM_NAMES.put(AL_STREAMS.get("Bio Science with Agriculture"), "bio_science_agriculture");
    }

    // Subject difficulty levels (adjusted weights)
    public static final Map<Integer, Double> SUBJECT_DIFFICULTY = new HashMap<>();
    static {
        // OL Subjects
        SUBJECT_DIFFICULTY.put(OL_SUBJECTS.get("Maths"), 1.0);
        SUBJECT_DIFFICULTY.put(OL_SUBJECTS.get("Science"), 0.8);
        SUBJECT_DIFFICULTY.put(OL_SUBJECTS.get("English"), 0.7);
        SUBJECT_DIFFICULTY.put(OL_SUBJECTS.get("Sinhala"), 0.5);
        SUBJECT_DIFFICULTY.put(OL_SUBJECTS.get("History"), 0.4);
        SUBJECT_DIFFICULTY.put(OL_SUBJECTS.get("Religion"), 0.2);

        // AL Subjects
        SUBJECT_DIFFICULTY.put(AL_SUBJECTS.get("Physics"), 0.9);
        SUBJECT_DIFFICULTY.put(AL_SUBJECTS.get("Chemistry"), 0.85);
        SUBJECT_DIFFICULTY.put(AL_SUBJECTS.get("Combined_Maths"), 0.9);
        SUBJECT_DIFFICULTY.put(AL_SUBJECTS.get("Biology"), 0.8);
        SUBJECT_DIFFICULTY.put(AL_SUBJECTS.get("ICT"), 0.75);
        SUBJECT_DIFFICULTY.put(AL_SUBJECTS.get("Agriculture"), 0.7);
        SUBJECT_DIFFICULTY.put(AL_SUBJECTS.get("Economics"), 0.65);
        SUBJECT_DIFFICULTY.put(AL_SUBJECTS.get("Business_Studies"), 0.6);
    }

    // Grade distributions for AL subjects (sum to 1.0)
    public static final Map<Integer, Map<String, Double>> GRADE_DISTRIBUTIONS = new HashMap<>();
    static {
        GRADE_DISTRIBUTIONS.put(AL_SUBJECTS.get("Physics"), Map.of(
                "A", 0.15, "B", 0.25, "C", 0.35, "S", 0.15, "F", 0.10
        ));
        GRADE_DISTRIBUTIONS.put(AL_SUBJECTS.get("Chemistry"), Map.of(
                "A", 0.20, "B", 0.30, "C", 0.30, "S", 0.15, "F", 0.05
        ));
        GRADE_DISTRIBUTIONS.put(AL_SUBJECTS.get("Combined_Maths"), Map.of(
                "A", 0.10, "B", 0.20, "C", 0.40, "S", 0.20, "F", 0.10
        ));
        GRADE_DISTRIBUTIONS.put(AL_SUBJECTS.get("Biology"), Map.of(
                "A", 0.25, "B", 0.30, "C", 0.30, "S", 0.10, "F", 0.05
        ));
        GRADE_DISTRIBUTIONS.put(AL_SUBJECTS.get("ICT"), Map.of(
                "A", 0.25, "B", 0.35, "C", 0.25, "S", 0.10, "F", 0.05
        ));
        GRADE_DISTRIBUTIONS.put(AL_SUBJECTS.get("Agriculture"), Map.of(
                "A", 0.30, "B", 0.35, "C", 0.25, "S", 0.08, "F", 0.02
        ));
    }

    // Z-score ranges by stream (instead of per subject)
    public static final Map<Integer, double[]> Z_SCORE_RANGE = new HashMap<>();
    static {
        Z_SCORE_RANGE.put(AL_STREAMS.get("Physical Science"), new double[]{1.8, 3.2});
        Z_SCORE_RANGE.put(AL_STREAMS.get("Biological Science"), new double[]{1.6, 3.0});
        Z_SCORE_RANGE.put(AL_STREAMS.get("Physical Science with ICT"), new double[]{1.7, 3.1});
        Z_SCORE_RANGE.put(AL_STREAMS.get("Bio Science with Agriculture"), new double[]{1.5, 2.9});
    }

    // GPA ranges by university tier (0 = top universities, 1 = mid-tier, etc.)
    public static final Map<Integer, double[]> GPA_RANGE = new HashMap<>();
    static {
        GPA_RANGE.put(0, new double[]{3.7, 4.0});  // Top tier
        GPA_RANGE.put(1, new double[]{3.3, 3.7});  // Mid tier
        GPA_RANGE.put(2, new double[]{2.7, 3.3});  // Standard
    }

    // Career definitions
    public static final Map<String, Integer> CAREERS = new HashMap<>();
    static {
        CAREERS.put("Engineering", 0);
        CAREERS.put("Medicine", 1);
        CAREERS.put("IT", 2);
        CAREERS.put("Business", 3);
        CAREERS.put("Teaching", 4);
        CAREERS.put("Research", 5);
    }

    // Base career compatibility probabilities
    public static final Map<Integer, Double> CAREER_COMPATIBILITY = new HashMap<>();
    static {
        CAREER_COMPATIBILITY.put(CAREERS.get("Engineering"), 0.15);
        CAREER_COMPATIBILITY.put(CAREERS.get("Medicine"), 0.10);
        CAREER_COMPATIBILITY.put(CAREERS.get("IT"), 0.20);
        CAREER_COMPATIBILITY.put(CAREERS.get("Business"), 0.25);
        CAREER_COMPATIBILITY.put(CAREERS.get("Teaching"), 0.30);
        CAREER_COMPATIBILITY.put(CAREERS.get("Research"), 0.05);
    }

    // Career compatibility bonuses (using defined factors)
    public static final Map<Integer, Map<Integer, Double>> CAREER_COMPATIBILITY_BONUS = new HashMap<>();
    static {
        // Engineering: Emphasize math/physics
        CAREER_COMPATIBILITY_BONUS.put(CAREERS.get("Engineering"), Map.of(
                Z_SCORE_FACTOR, 0.25,  // Z-score impact
                GPA_FACTOR, 0.15,      // GPA impact
                OL_SUBJECTS.get("Maths"), 0.3,
                OL_SUBJECTS.get("Science"), 0.2,
                AL_SUBJECTS.get("Physics"), 0.8,
                AL_SUBJECTS.get("Combined_Maths"), 0.9,
                AL_STREAMS.get("Physical Science"), 0.5,
                AL_STREAMS.get("Physical Science with ICT"), 0.4
        ));

        // Medicine: Focus on biology/chemistry
        CAREER_COMPATIBILITY_BONUS.put(CAREERS.get("Medicine"), Map.of(
                Z_SCORE_FACTOR, 0.30,
                GPA_FACTOR, 0.20,
                OL_SUBJECTS.get("Science"), 0.4,
                OL_SUBJECTS.get("English"), 0.3,
                AL_SUBJECTS.get("Biology"), 0.9,
                AL_SUBJECTS.get("Chemistry"), 0.8,
                AL_STREAMS.get("Biological Science"), 0.6,
                AL_STREAMS.get("Bio Science with Agriculture"), 0.5
        ));

        // IT: ICT and math skills
        CAREER_COMPATIBILITY_BONUS.put(CAREERS.get("IT"), Map.of(
                Z_SCORE_FACTOR, 0.20,
                GPA_FACTOR, 0.10,
                OL_SUBJECTS.get("Maths"), 0.4,
                AL_SUBJECTS.get("ICT"), 0.9,
                AL_SUBJECTS.get("Combined_Maths"), 0.7,
                AL_STREAMS.get("Physical Science with ICT"), 0.8,
                AL_STREAMS.get("Physical Science"), 0.6
        ));

        // Business: Economics and communication
        CAREER_COMPATIBILITY_BONUS.put(CAREERS.get("Business"), Map.of(
                Z_SCORE_FACTOR, 0.10,
                GPA_FACTOR, 0.05,
                OL_SUBJECTS.get("Maths"), 0.6,
                OL_SUBJECTS.get("English"), 0.5,
                AL_SUBJECTS.get("Economics"), 0.8,
                AL_SUBJECTS.get("Business_Studies"), 0.9,
                AL_STREAMS.get("Physical Science"), 0.4,
                AL_STREAMS.get("Physical Science with ICT"), 0.3
        ));

        // Teaching: Subject mastery + communication
        CAREER_COMPATIBILITY_BONUS.put(CAREERS.get("Teaching"), Map.of(
                Z_SCORE_FACTOR, 0.05,
                GPA_FACTOR, 0.02,
                OL_SUBJECTS.get("English"), 0.7,
                OL_SUBJECTS.get("Sinhala"), 0.6,
                AL_SUBJECTS.get("Biology"), 0.7,
                AL_SUBJECTS.get("Chemistry"), 0.6,
                AL_STREAMS.get("Biological Science"), 0.5,
                AL_STREAMS.get("Bio Science with Agriculture"), 0.4
        ));

        // Research: High academic performance
        CAREER_COMPATIBILITY_BONUS.put(CAREERS.get("Research"), Map.of(
                Z_SCORE_FACTOR, 0.40,
                GPA_FACTOR, 0.30,
                OL_SUBJECTS.get("Science"), 0.8,
                OL_SUBJECTS.get("Maths"), 0.7,
                AL_SUBJECTS.get("Physics"), 0.9,
                AL_SUBJECTS.get("Chemistry"), 0.8,
                AL_STREAMS.get("Physical Science"), 0.6,
                AL_STREAMS.get("Physical Science with ICT"), 0.5,
                AL_STREAMS.get("Biological Science"), 0.4,
                AL_STREAMS.get("Bio Science with Agriculture"), 0.3
        ));
    }
}