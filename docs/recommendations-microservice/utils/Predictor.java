package com.nextstep.recommendations.utils;

import com.nextstep.recommendations.model.StudentProfile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import weka.classifiers.Classifier;
import weka.core.DenseInstance;
import weka.core.Instances;
import weka.core.SerializationHelper;
import weka.core.converters.ConverterUtils.DataSource;

import java.util.HashMap;
import java.util.Map;

@Component
public class Predictor {
    private final Classifier model;
    private final Instances dataset;

    @Autowired
    public Predictor(@Value("${model.dir}") String modelDir) throws Exception {
        this.model = (Classifier) SerializationHelper.read(modelDir + "career_prediction.model");
        this.dataset = DataSource.read(modelDir + "features.arff");
        this.dataset.setClassIndex(this.dataset.numAttributes() - 1);
    }

    public StudentProfile updateCareerProbabilities(StudentProfile studentProfile) throws Exception {
        DenseInstance instance = createInstance(studentProfile);
        double[] probabilities = model.distributionForInstance(instance);

        Map<String, Double> careerProbabilities = new HashMap<>();
        for (int i = 0; i < probabilities.length; i++) {
            String careerName = dataset.classAttribute().value(i);
            careerProbabilities.put(careerName, probabilities[i]);
        }

        studentProfile.setCareerProbabilities(careerProbabilities);
        return studentProfile;
    }

    private DenseInstance createInstance(StudentProfile studentProfile) {
        DenseInstance instance = new DenseInstance(dataset.numAttributes());
        instance.setDataset(dataset);

        // Set education level
        instance.setValue(dataset.attribute("education_level"), studentProfile.getEducationLevel());

        // Set OL results
        for (Map.Entry<String, Double> entry : studentProfile.getOlResults().entrySet()) {
            String colName = "OL_subject_" + entry.getKey() + "_score";
            if (dataset.attribute(colName) != null) {
                instance.setValue(dataset.attribute(colName), entry.getValue());
            }
        }

        // Set AL stream (if available)
        if (studentProfile.getAlStream() != null) {
            instance.setValue(dataset.attribute("AL_stream"), studentProfile.getAlStream());
        }

        // Set AL results (if available)
        if (studentProfile.getAlResults() != null) {
            for (Map.Entry<String, Double> entry : studentProfile.getAlResults().entrySet()) {
                String colName = "AL_subject_" + entry.getKey() + "_score";
                if (dataset.attribute(colName) != null) {
                    instance.setValue(dataset.attribute(colName), entry.getValue());
                }
            }
        }

        // Set GPA (if available)
        if (studentProfile.getGpa() != null) {
            instance.setValue(dataset.attribute("gpa"), studentProfile.getGpa());
        }

        return instance;
    }
}