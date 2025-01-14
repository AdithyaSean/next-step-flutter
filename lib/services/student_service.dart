import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/student.dart';

class StudentService {
  final String baseUrl;

  StudentService(this.baseUrl);

  Future<List<Student>> getStudents() async {
    final response = await http.get(Uri.parse('$baseUrl/students'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Student> students = body.map((dynamic item) => Student.fromJson(item)).toList();
      return students;
    } else {
      throw Exception('Failed to load students');
    }
  }

  Future<Student> getStudentById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/students/$id'));

    if (response.statusCode == 200) {
      return Student.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load student');
    }
  }

  Future<void> addStudent(Student student) async {
    final response = await http.post(
      Uri.parse('$baseUrl/students'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(student.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add student');
    }
  }

  Future<void> updateStudent(Student student) async {
    final response = await http.put(
      Uri.parse('$baseUrl/students/${student.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(student.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update student');
    }
  }

  Future<void> deleteStudent(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/students/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete student');
    }
  }
}