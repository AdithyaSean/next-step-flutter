class Career {
  final String code;
  final String title;
  final String description;
  final String category;
  final List<String> requiredSkills;
  final List<String> relatedCourses;
  final Map<String, String> externalLinks;

  Career({
    required this.code,
    required this.title,
    required this.description,
    required this.category,
    required this.requiredSkills,
    required this.relatedCourses,
    required this.externalLinks,
  });

  factory Career.fromJson(Map<String, dynamic> json) {
    return Career(
      code: json['code'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      requiredSkills: List<String>.from(json['requiredSkills']),
      relatedCourses: List<String>.from(json['relatedCourses']),
      externalLinks: Map<String, String>.from(json['externalLinks']),
    );
  }
}
