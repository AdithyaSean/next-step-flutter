package com.nextstep.backend.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Service;
import org.springframework.core.io.ClassPathResource;
import javax.annotation.PostConstruct;
import java.io.IOException;
import java.util.*;
import org.python.core.PyObject;
import org.python.util.PythonInterpreter;

@Service
public class CareerPredictionService {
    private PyObject model;
    private Map<String, Object> metadata;
    private List<String> featureColumns;
    private List<String> careerPaths;
    private final String MODEL_PATH = "models/career_path_predictor.joblib";
    private final String METADATA_PATH = "models/career_path_predictor_metadata.json";

    @PostConstruct
    public void init() throws IOException {
        // Load model metadata
        ObjectMapper mapper = new ObjectMapper();
        metadata = mapper.readValue(new ClassPathResource(METADATA_PATH).getInputStream(), Map.class);
        featureColumns = (List<String>) metadata.get("feature_columns");
        careerPaths = (List<String>) metadata.get("career_paths");

        // Initialize Python interpreter
        PythonInterpreter.initialize(System.getProperties(), System.getProperties(), new String[0]);
        try (PythonInterpreter pyInterp = new PythonInterpreter()) {
            // Import required modules
            pyInterp.exec("import joblib");
            pyInterp.exec("import numpy as np");

            // Load the model
            String modelPath = new ClassPathResource(MODEL_PATH).getFile().getAbsolutePath();
            pyInterp.exec(String.format("model = joblib.load('%s')", modelPath));
            model = pyInterp.get("model");
        }
    }

    public List<CareerPrediction> predictCareerPaths(StudentData student) {
        try (PythonInterpreter pyInterp = new PythonInterpreter()) {
            // Convert student data to feature array
            double[] features = new double[featureColumns.size()];
            for (int i = 0; i < featureColumns.size(); i++) {
                String feature = featureColumns.get(i);
                features[i] = student.getFeatureValue(feature);
            }

            // Convert to numpy array
            pyInterp.set("features", features);
            pyInterp.exec("features = np.array(features).reshape(1, -1)");

            // Make prediction
            pyInterp.exec("predictions = model.predict_proba(features)");
            PyObject predictions = pyInterp.get("predictions");

            // Convert predictions to Java objects
            List<CareerPrediction> results = new ArrayList<>();
            for (int i = 0; i < careerPaths.size(); i++) {
                String careerPath = careerPaths.get(i).replace("career_path_", "");
                double probability = ((PyObject) predictions.__getitem__(i)).__getitem__(1).asDouble();

                if (probability >= 0.5) {  // Only include likely career paths
                    results.add(new CareerPrediction(careerPath, probability));
                }
            }

            // Sort by probability
            results.sort((a, b) -> Double.compare(b.getProbability(), a.getProbability()));
            return results;
        }
    }

    // Inner class for career predictions
    public static class CareerPrediction {
        private String careerPath;
        private double probability;

        public CareerPrediction(String careerPath, double probability) {
            this.careerPath = careerPath;
            this.probability = probability;
        }

        public String getCareerPath() { return careerPath; }
        public double getProbability() { return probability; }
    }
}
