import 'dart:developer' as developer;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class TFLiteService {
  static const String model = 'assets/model.tflite';
  static const String labels = 'assets/labels.json';
  
  Interpreter? _interpreter;
  Map<String, dynamic>? _labels;

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
        final value = studentData[feature];
        
        if (value != null) {
          // Convert various input types to double
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
      for (var i = 0; i < _labels!['career_paths'].length; i++) {
        predictions[_labels!['career_paths'][i]] = outputArray[0][i];
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