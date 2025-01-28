import 'package:flutter/material.dart';
import 'package:next_step/models/student_profile.dart';
import 'package:next_step/services/student_service.dart';

class EditProfileScreen extends StatefulWidget {
  final StudentProfile initialProfile;

  const EditProfileScreen({super.key, required this.initialProfile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late StudentProfile _profile;
  final StudentService _studentService = StudentService();

  @override
  void initState() {
    super.initState();
    _profile = widget.initialProfile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPersonalInfoFields(),
              const SizedBox(height: 24),
              _buildEducationLevelField(),
              const SizedBox(height: 16),
              _buildOLResultsFields(),
              const SizedBox(height: 16),
              _buildALStreamField(),
              const SizedBox(height: 16),
              _buildALResultsFields(),
              const SizedBox(height: 16),
              _buildGPAField(),
              const SizedBox(height: 24),
              _buildCertificationsField(),
              const SizedBox(height: 24),
              _buildInterestsField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Personal Information',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextFormField(
          initialValue: _profile.name,
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => setState(() => _profile.name = value),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: _profile.email,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => setState(() => _profile.email = value),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: _profile.phone,
          decoration: const InputDecoration(
            labelText: 'Phone',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => setState(() => _profile.phone = value),
        ),
      ],
    );
  }

  Widget _buildEducationLevelField() {
    return DropdownButtonFormField<int>(
      value: _profile.educationLevel,
      decoration: const InputDecoration(
        labelText: 'Education Level',
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: 1, child: Text('O/L')),
        DropdownMenuItem(value: 2, child: Text('A/L')),
      ],
      onChanged: (value) {
        setState(() {
          _profile.educationLevel = value ?? 1;
        });
      },
    );
  }

  Widget _buildOLResultsFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'O/L Results',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ..._profile.olResults.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextFormField(
              initialValue: entry.value.toString(),
              decoration: InputDecoration(
                labelText: entry.key,
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _profile.olResults[entry.key] = double.tryParse(value) ?? 0.0;
                });
              },
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildALStreamField() {
    return DropdownButtonFormField<int>(
      value: _profile.alStream,
      decoration: const InputDecoration(
        labelText: 'A/L Stream',
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: 1, child: Text('Science')),
        DropdownMenuItem(value: 2, child: Text('Commerce')),
        DropdownMenuItem(value: 3, child: Text('Arts')),
      ],
      onChanged: (value) {
        setState(() {
          _profile.alStream = value ?? 1;
        });
      },
    );
  }

  Widget _buildALResultsFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'A/L Results',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ..._profile.alResults.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextFormField(
              initialValue: entry.value.toString(),
              decoration: InputDecoration(
                labelText: entry.key,
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _profile.alResults[entry.key] = double.tryParse(value) ?? 0.0;
                });
              },
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildGPAField() {
    return TextFormField(
      initialValue: _profile.gpa.toString(),
      decoration: const InputDecoration(
        labelText: 'GPA',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {
          _profile.gpa = double.tryParse(value) ?? 0.0;
        });
      },
    );
  }

  Widget _buildCertificationsField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Certifications',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _profile.certifications.length + 1,
          itemBuilder: (context, index) {
            if (index == _profile.certifications.length) {
              return TextButton(
                onPressed: () {
                  setState(() {
                    _profile.certifications.add('');
                  });
                },
                child: const Text('Add Certification'),
              );
            }
            return Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: _profile.certifications[index],
                    decoration: const InputDecoration(
                      labelText: 'Certification',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _profile.certifications[index] = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      _profile.certifications.removeAt(index);
                    });
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildInterestsField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Interests',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            ..._profile.interests.map((interest) {
              return Chip(
                label: Text(interest),
                onDeleted: () {
                  setState(() {
                    _profile.interests.remove(interest);
                  });
                },
              );
            }),
            ActionChip(
              label: const Icon(Icons.add),
              onPressed: () {
                _showAddInterestDialog();
              },
            ),
          ],
        ),
      ],
    );
  }

  void _showAddInterestDialog() {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Interest'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            labelText: 'Interest',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                setState(() {
                  _profile.interests.add(textController.text);
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _studentService.updateProfile('current-user-id', _profile);
        if (!mounted) return;

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );

        // Return to profile screen
        Navigator.pop(context, _profile);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      }
    }
  }
}
