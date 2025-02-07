import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_step/models/user.dart';
import 'package:next_step/models/student_profile.dart';
import 'package:next_step/controllers/student_controller.dart';
import 'package:next_step/utils/education_config.dart';
import 'home.dart';

class EditProfileScreen extends StatefulWidget {
  final User initialProfile;

  const EditProfileScreen({super.key, required this.initialProfile});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final StudentController _studentController = Get.find<StudentController>();
  final TextEditingController _gpaController = TextEditingController();

  String? _educationLevel;
  int? _alStream;
  final Map<String, double> _olResults = {};
  final Map<String, double> _alResults = {};

  @override
  void initState() {
    super.initState();
    _educationLevel = EducationConfig.educationLevels.keys.firstWhere(
      (key) => EducationConfig.educationLevels[key] == widget.initialProfile.educationLevel,
      orElse: () => 'OL',
    );
    _alStream = widget.initialProfile.alStream;
    _gpaController.text = widget.initialProfile.gpa == 0.0 ? '' : widget.initialProfile.gpa.toString();

    // Initialize OL subjects with values from profile
    for (var subject in EducationConfig.requiredOLSubjects) {
      _olResults[subject] = widget.initialProfile.olResults[subject] ?? EducationConfig.gradeNotSet;
    }

    // Initialize AL subjects if stream is selected
    if (_alStream != null) {
      final streamSubjects = EducationConfig.streamSubjects[_alStream] ?? [];
      for (var subject in streamSubjects) {
        _alResults[subject] = widget.initialProfile.alResults[subject] ?? EducationConfig.gradeNotSet;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildEducationLevelDropdown(),
            const SizedBox(height: 16),
            _buildOLResultsSection(),
            const SizedBox(height: 16),
            if (_educationLevel != 'OL') ...[
              _buildALSection(),
              if (_educationLevel == 'UNI') ...[
                const SizedBox(height: 16),
                _buildTextField(_gpaController, 'GPA (0.0 - 4.0)', isNumber: true),
              ],
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _validateAndSaveProfile,
              child: const Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    );
  }

  Widget _buildEducationLevelDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Education Level',
        border: OutlineInputBorder(),
      ),
      value: _educationLevel,
      items: EducationConfig.educationLevels.keys.map((level) {
        return DropdownMenuItem<String>(
          value: level,
          child: Text(level),
        );
      }).toList(),
      onChanged: (value) {
        if (value == null) return;
        setState(() {
          _educationLevel = value;
          if (value == 'OL') {
            _alStream = null;
            _alResults.clear();
          }
        });
      },
    );
  }

  Widget _buildGradeDropdown(String subject, Map<String, double> results) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Grade',
        border: OutlineInputBorder(),
      ),
      value: EducationConfig.getGradeLetter(results[subject] ?? EducationConfig.gradeNotSet),
      items: EducationConfig.grades.entries.map((grade) {
        return DropdownMenuItem<String>(
          value: grade.key,
          child: Text(grade.key),
        );
      }).toList(),
      onChanged: (value) {
        if (value == null) return;
        setState(() {
          results[subject] = EducationConfig.grades[value]!;
        });
      },
    );
  }

  Widget _buildOLResultsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('O/L Results', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...EducationConfig.requiredOLSubjects.map((subject) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(child: Text(subject)),
                const SizedBox(width: 16),
                Expanded(child: _buildGradeDropdown(subject, _olResults)),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildALSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<int>(
          decoration: const InputDecoration(
            labelText: 'A/L Stream',
            border: OutlineInputBorder(),
          ),
          value: _alStream,
          items: EducationConfig.alStreams.entries.map((entry) {
            return DropdownMenuItem<int>(
              value: entry.value,
              child: Text(entry.key),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _alStream = value;
              _alResults.clear();
              if (value != null) {
                final subjects = EducationConfig.streamSubjects[value] ?? [];
                for (var subject in subjects) {
                  _alResults[subject] = EducationConfig.gradeNotSet;
                }
              }
            });
          },
        ),
        if (_alStream != null) ...[
          const SizedBox(height: 16),
          const Text('A/L Results', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...(EducationConfig.streamSubjects[_alStream] ?? []).map((subject) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(child: Text(subject)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildGradeDropdown(subject, _alResults)),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }

  bool _validateProfile() {
    // Validate OL Results
    for (var subject in EducationConfig.requiredOLSubjects) {
      if (!_olResults.containsKey(subject) || 
          _olResults[subject] == EducationConfig.gradeNotSet) {
        Get.snackbar(
          'Error', 
          'Please select a grade for $subject',
          backgroundColor: Colors.red[100],
        );
        return false;
      }
    }

    // Check AL Requirements
    if (_educationLevel != 'OL') {
      if (_alStream == null) {
        Get.snackbar('Error', 'Please select an A/L stream',
            backgroundColor: Colors.red[100]);
        return false;
      }

      final streamSubjects = EducationConfig.streamSubjects[_alStream] ?? [];
      for (var subject in streamSubjects) {
        if (!_alResults.containsKey(subject) || 
            _alResults[subject] == EducationConfig.gradeNotSet) {
          Get.snackbar(
            'Error', 
            'Please select a grade for $subject',
            backgroundColor: Colors.red[100],
          );
          return false;
        }
      }
    }

    // Check University Requirements
    if (_educationLevel == 'UNI') {
      final gpa = double.tryParse(_gpaController.text);
      if (gpa == null || gpa < 0 || gpa > 4.0) {
        Get.snackbar('Error', 'Please enter a valid GPA between 0.0 and 4.0',
            backgroundColor: Colors.red[100]);
        return false;
      }
    }

    return true;
  }

  void _validateAndSaveProfile() {
    if (!_validateProfile()) return;

    final educationLevel = EducationConfig.educationLevels[_educationLevel] ?? 0;
    
    final studentProfile = StudentProfile(
      educationLevel: educationLevel,
      olResults: _olResults,
      alStream: _alStream,
      alResults: _alResults,
      gpa: educationLevel == EducationConfig.educationLevels['UNI'] 
          ? double.tryParse(_gpaController.text)
          : null,
    );

    _studentController.updateProfile(widget.initialProfile.copyWith(
      educationLevel: studentProfile.educationLevel,
      olResults: studentProfile.olResults,
      alStream: studentProfile.alStream,
      alResults: studentProfile.alResults,
      gpa: studentProfile.gpa,
    )).then((success) {
      if (success) {
        Get.offAll(() => const HomeScreen());
      }
    });
  }
}
