class Student {
  final String id;
  final String username;
  final String name;
  final String email;
  final String telephone;
  final String school;
  final String district;
  
  Student({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.telephone,
    required this.school,
    required this.district,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      telephone: json['telephone'],
      school: json['student']?['school'] ?? '',
      district: json['student']?['district'] ?? '',
    );
  }
}