import 'package:flutter/material.dart';
import '../data/database/app_database.dart';
import '../data/repositories/student_repository.dart';
import '../widgets/nav_bar.dart';
import '../screens/profile.dart';
import '../constants/education_constants.dart';
import 'package:get_it/get_it.dart';
import '../services/tflite_service.dart';
import 'package:drift/drift.dart' hide Column;  // Add this import

class ProfileEditScreen extends StatefulWidget {
  final String studentId;
  const ProfileEditScreen({super.key, required this.studentId});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _repository = GetIt.instance<StudentRepository>();
  final _tfliteService = GetIt.instance<TFLiteService>();
  bool _isLoading = false;

  // Use the actual Student model
  late StudentData _student;

  @override
  void initState() {
    super.initState();
    _initializeStudent();
  }

  Future<void> _initializeStudent() async {
    final data = await _repository.getStudent(widget.studentId);
    if (data != null) {
      setState(() {
        _student = StudentData.fromJson(data);  // Use generated fromJson
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildBasicInfo(),
              const SizedBox(height: 20),
              _buildOLResults(),
              const SizedBox(height: 20),
              _buildStreamSelector(),
              if (_student.stream != null) ...[
                const SizedBox(height: 20),
                _buildALResults(),
                const SizedBox(height: 20),
                _buildZScore(),
              ],
              const SizedBox(height: 20),
              _buildInterests(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleSubmit,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Save and Get Predictions'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavContainer(
        selectedIndex: 2,
        studentId: widget.studentId,
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: const InputDecoration(labelText: 'School'),
          initialValue: _student.school,
          onChanged: (value) => setState(() => 
            _student = _student.copyWith(school: Value(value))),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: _student.district.isEmpty ? null : _student.district,
          decoration: const InputDecoration(labelText: 'District'),
          items: ['Colombo', 'Gampaha', 'Kalutara'] // Add your districts list
              .map((district) => DropdownMenuItem(
                    value: district,
                    child: Text(district),
                  ))
              .toList(),
          onChanged: (value) => setState(() => _student = _student.copyWith(district: value)),
          validator: (value) => value?.isEmpty ?? true ? 'Please select a district' : null,
        ),
      ],
    );
  }

  Widget _buildOLResults() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'O/L Results',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...EducationConstants.olSubjects.map((subject) => _buildGradeSelector(
                  subject,
                  EducationConstants.grades,
                  _student.olResults[subject],
                  (grade) => setState(() {
                    final newResults = Map<String, String>.from(_student.olResults);
                    newResults[subject] = grade;
                    _student = _student.copyWith(alResults: newResults);
                  }),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildStreamSelector() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(labelText: 'A/L Stream'),
      items: EducationConstants.streamSubjects.keys
          .map((stream) => DropdownMenuItem(
                value: stream,
                child: Text(stream),
              ))
          .toList(),
      value: (_student.stream != null && _student.stream!.isNotEmpty) ? _student.stream : null,
      onChanged: (value) => setState(() => 
        _student = _student.copyWith(stream: Value(value))),
    );
  }

  Widget _buildALResults() {
    if (_student.stream == null) return const SizedBox.shrink();

    final subjects = EducationConstants.streamSubjects[_student.stream!] ?? [];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'A/L Results',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...subjects.map((subject) => _buildGradeSelector(
                  subject,
                  EducationConstants.grades,
                  _student.alResults[subject],
                  (grade) {
                    final newResults = Map<String, String>.from(_student.alResults);
                    newResults[subject] = grade;
                    setState(() => _student = _student.copyWith(alResults: newResults,
                    ));
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeSelector(
    String subject,
    List<String> grades,
    String? initialValue,
    void Function(String) onChanged,
  ) {
    // Ensure grades list has unique values
    final uniqueGrades = grades.toSet().toList();
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: Text(subject)),
          DropdownButton<String>(
            value: uniqueGrades.contains(initialValue) ? initialValue : null,
            hint: const Text('Select Grade'),
            items: uniqueGrades
                .map((grade) => DropdownMenuItem(
                      value: grade,
                      child: Text(grade),
                    ))
                .toList(),
            onChanged: (value) => value != null ? onChanged(value) : null,
          ),
        ],
      ),
    );
  }

  Widget _buildZScore() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Z-Score'),
      keyboardType: TextInputType.number,
      onSaved: (value) => _student = _student.copyWith(
        zScore: Value(double.tryParse(value ?? '')),
      ),
    );
  }

  Widget _buildInterests() {
    // Get interests from TFLite service
    final interests = GetIt.instance<TFLiteService>().interestNames;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Interests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: interests.map((interest) {
                final isSelected = _student.interests.contains(interest);
                return FilterChip(
                  label: Text(interest),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _student = _student.copyWith(
                            interests: [..._student.interests, interest]);
                      } else {
                        _student = _student.copyWith(
                            interests: _student.interests
                                .where((i) => i != interest)
                                .toList());
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _isLoading = true);

    try {
      // Get predictions using TFLite model
      final predictions = await _tfliteService.predict(_student.toJson());
      
      // Update student with new data including predictions
      await _repository.createStudent({
        ..._student.toJson(),
        'predictions': predictions,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );

      // Navigate to profile view
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(studentId: widget.studentId),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
