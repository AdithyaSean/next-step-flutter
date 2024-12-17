import 'dart:developer' as developer;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class TFLiteService {
  static const String model = 'assets/model.tflite';
  static const String labels = 'assets/labels.json';
  
  Interpreter? _interpreter;
  Map<String, dynamic>? _labels;

  // Add this mapping from feature columns to user-friendly interest names
  final Map<String, String> _featureToInterestMap = {
    'ai': 'Artificial Intelligence',
    'science': 'Science',
    'math': 'Mathematics',
    'cs': 'Computer Science',
    // Add mappings for all feature columns
  };

  // Mapping from user-friendly interests to model feature names
  final Map<String, String> _interestToFeatureMap = {
    'Artificial Intelligence': 'ai_feature',
    'Science': 'science_feature',
    'Mathematics': 'math_feature',
    'Computer Science': 'cs_feature',
    'Biology': 'biology_feature',
    'Physics': 'physics_feature',
    'English': 'english_feature',
    'Law': 'law_feature',
    'Music': 'music_feature',
    'Dancing': 'dancing_feature',
    'History': 'history_feature',
    'Languages': 'languages_feature',
    'Robotics': 'robotics_feature',
    'Drama': 'drama_feature',
    'Computer Networks': 'networks_feature',
    'Cybersecurity': 'cybersecurity_feature',
    'Chemistry': 'chemistry_feature',
    'Engineering': 'engineering_feature',
    // Add mappings for all interests as needed
  };

  Future<void> initialize() async {
    try {
      // Load model
      _interpreter = await Interpreter.fromAsset(model);
      developer.log('Model loaded successfully', name: 'TFLiteService');
      developer.log('Input tensor shape: ${_interpreter?.getInputTensor(0).shape}', 
          name: 'TFLiteService');
      developer.log('Output tensor shape: ${_interpreter?.getOutputTensor(0).shape}', 
          name: 'TFLiteService');

      // Load labels
      final labelsJson = await rootBundle.loadString(labels);
      _labels = json.decode(labelsJson);
      developer.log('Labels loaded successfully: ${_labels?["feature_columns"].length} features', 
          name: 'TFLiteService');

    } catch (e) {
      developer.log('Error initializing TFLite: $e', 
          name: 'TFLiteService', error: e);
      rethrow;
    }
  }

  Future<Map<String, double>> predict(Map<String, dynamic> studentData) async {
    if (_interpreter == null || _labels == null) {
      throw Exception('TFLite interpreter or labels not initialized');
    }

    try {
      // Prepare input data according to feature_columns order
      List<double> inputData = List.filled(_labels!['input_shape'], 0.0);
      
      for (var i = 0; i < _labels!['feature_columns'].length; i++) {
        final feature = _labels!['feature_columns'][i];

        // Map user-selected interests to model features
        if (_interestToFeatureMap.values.contains(feature)) {
          // Find the interest corresponding to this feature
          final interest = _interestToFeatureMap.entries
              .firstWhere(
                (entry) => entry.value == feature,
                orElse: () => MapEntry('', ''),
              )
              .key;

          if (interest.isNotEmpty &&
              studentData['interests'] != null &&
              studentData['interests'].contains(interest)) {
            inputData[i] = 1.0; // User selected this interest
          } else {
            inputData[i] = 0.0; // User did not select this interest
          }
        } else {
          // Handle other features
          final value = studentData[feature];
          inputData[i] = _convertToDouble(value);
        }

        developer.log('Feature $feature: ${inputData[i]}',
            name: 'TFLiteService');
      }

      // Prepare input and output tensors
      var inputArray = [inputData];
      var outputShape = 1 * _labels!['output_shape'];
      var outputArray = List.filled(outputShape.toInt(), 0.0).reshapeTensor(
          [1, _labels!['output_shape'].toInt()]);

      // Run inference
      _interpreter!.run(inputArray, outputArray);

      // Convert output to map of career paths and probabilities
      Map<String, double> predictions = {};
      double sum = 0;
      
      // First pass to calculate sum for normalization
      for (var i = 0; i < _labels!['career_paths'].length; i++) {
        sum += outputArray[0][i];
      }

      // Second pass to create normalized probabilities
      for (var i = 0; i < _labels!['career_paths'].length; i++) {
        final probability = outputArray[0][i] / sum; // Normalize to get percentage
        predictions[_labels!['career_paths'][i]] = probability;
      }

      developer.log('Predictions: $predictions', name: 'TFLiteService');
      return predictions;

    } catch (e) {
      developer.log('Error during prediction: $e', 
          name: 'TFLiteService', error: e);
      rethrow;
    }
  }

  double _convertToDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      // Convert grade strings to numbers
      switch (value.toUpperCase()) {
        case 'A': return 4.0;
        case 'B': return 3.0;
        case 'C': return 2.0;
        case 'S': return 1.0;
        case 'F': return 0.0;
        default:
          return double.tryParse(value) ?? 0.0;
      }
    }
    if (value is bool) return value ? 1.0 : 0.0;
    return 0.0;
  }

  // Method to get the list of interest names
  List<String> get interestNames {
    // Get feature columns from labels
    List<String> features = List<String>.from(_labels?['feature_columns'] ?? []);
    // Map them to user-friendly interest names
    return features.map((feature) => _featureToInterestMap[feature] ?? feature).toList();
  }

  void dispose() {
    _interpreter?.close();
  }
}

extension TensorReshape on List<double> {
  List<List<double>> reshapeTensor(List<int> shape) {
    if (shape.length != 2) throw Exception('Only 2D reshaping is supported');
    
    final rows = shape[0];
    final cols = shape[1];
    final result = List.generate(
      rows,
      (i) => List.generate(
        cols,
        (j) => this[i * cols + j],
      ),
    );
    return result;
  }
}