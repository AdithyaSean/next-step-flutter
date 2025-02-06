import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_step/controllers/student_controller.dart';
import 'package:next_step/models/student_profile.dart';
import 'package:next_step/services/student_service.dart';
import 'package:next_step/utils/education_config.dart';

class EditProfileScreen extends StatefulWidget {
  final StudentProfile initialProfile;

  const EditProfileScreen({super.key, required this.initialProfile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late StudentProfile _profile;
  final _formKey = GlobalKey<FormState>();
  final StudentService _studentService = Get.find<StudentService>();

  @override
  void initState() {
    super.initState();
    _profile = StudentProfile(
      id: widget.initialProfile.id,
      educationLevel: widget.initialProfile.educationLevel,
      olResults: Map<String, double>.from(widget.initialProfile.olResults),
      alStream: widget.initialProfile.alStream,
      alResults: Map<String, double>.from(widget.initialProfile.alResults),
      careerProbabilities: Map<String, double>.from(widget.initialProfile.careerProbabilities),
      gpa: widget.initialProfile.gpa,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildEducationLevelSelector(),
              const SizedBox(height: 16),
              _buildOLResultsSection(),
              if (_profile.educationLevel > 1) ...[
                const SizedBox(height: 16),
                _buildALStreamSelector(),
                const SizedBox(height: 16),
                _buildALResultsSection(),
              ],
              if (_profile.educationLevel == 3) ...[
                const SizedBox(height: 16),
                _buildGPASection(),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEducationLevelSelector() {
    return DropdownButtonFormField<int>(
      value: _profile.educationLevel,
      decoration: const InputDecoration(
        labelText: 'Education Level',
        border: OutlineInputBorder(),
      ),
      items: EducationConfig.educationLevels.entries
          .map((entry) => DropdownMenuItem<int>(
                value: entry.key,
                child: Text(entry.value),
              ))
          .toList(),
      onChanged: (int? value) {
        if (value != null) {
          setState(() {
            _profile.educationLevel = value;
            if (value == 1) {
              // O/L selected
              _profile.alStream = null;
              _profile.alResults.clear();
              _profile.gpa = 0.0;
            } else if (value == 2) {
              // A/L selected
              if (_profile.alStream == null) {
                _profile.alStream = EducationConfig.defaultStream;
                _initializeAlResults();
              }
              _profile.gpa = 0.0;
            }
            // value == 3 means University, keep GPA
          });
        }
      },
    );
  }

  Widget _buildOLResultsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('O/L Results', 
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...EducationConfig.olSubjects.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: entry.key,
                border: const OutlineInputBorder(),
              ),
              initialValue: _profile.olResults[entry.key]?.toString() ?? '0',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Required';
                final grade = double.tryParse(value);
                if (grade == null || grade < 0 || grade > 100) {
                  return 'Enter valid grade (0-100)';
                }
                return null;
              },
              onSaved: (value) {
                _profile.olResults[entry.key] = double.parse(value ?? '0');
              },
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildALStreamSelector() {
    return DropdownButtonFormField<int>(
      value: _profile.alStream ?? EducationConfig.defaultStream,
      decoration: const InputDecoration(
        labelText: 'A/L Stream',
        border: OutlineInputBorder(),
      ),
      items: EducationConfig.alStreams.entries.map((entry) => 
        DropdownMenuItem(
          value: entry.key,
          child: Text(entry.value),
        ),
      ).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _profile.alStream = value;
            _initializeAlResults();
          });
        }
      },
    );
  }

  Widget _buildALResultsSection() {
    if (_profile.alStream == null) return const SizedBox.shrink();
    
    final streamName = EducationConfig.alStreams[_profile.alStream];
    final subjects = EducationConfig.streamSubjects[streamName] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('A/L Results', 
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...subjects.map((subject) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: subject,
                border: const OutlineInputBorder(),
              ),
              initialValue: _profile.alResults[subject]?.toString() ?? '0',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Required';
                final grade = double.tryParse(value);
                if (grade == null || grade < 0 || grade > 100) {
                  return 'Enter valid grade (0-100)';
                }
                return null;
              },
              onSaved: (value) {
                _profile.alResults[subject] = double.parse(value ?? '0');
              },
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildGPASection() {
    // Only show if University level
    if (_profile.educationLevel != 3) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('University Details', 
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'GPA (0.0 - 4.0)',
            border: OutlineInputBorder(),
            hintText: 'Enter your GPA',
          ),
          initialValue: _profile.gpa.toStringAsFixed(2),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (value) {
            if (_profile.educationLevel == 3) {
              if (value == null || value.isEmpty) return 'Required for university students';
              final gpa = double.tryParse(value);
              if (gpa == null || gpa < 0 || gpa > 4.0) {
                return 'Enter valid GPA (0-4.0)';
              }
            }
            return null;
          },
          onSaved: (value) {
            if (_profile.educationLevel == 3) {
              _profile.gpa = double.parse(value ?? '0');
            }
          },
        ),
      ],
    );
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _studentService.updateProfile(_profile.id, _profile);
        final studentController = Get.find<StudentController>();
        await studentController.loadProfile();
        Get.back();
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to update profile: $e',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  void _initializeAlResults() {
    _profile.alResults.clear();
    final streamName = EducationConfig.alStreams[_profile.alStream];
    if (streamName != null) {
      final subjects = EducationConfig.streamSubjects[streamName] ?? [];
      for (var subject in subjects) {
        _profile.alResults[subject] = 0.0;
      }
    }
  }
}
