class EducationConfig {
  // Education levels
  static const Map<String, int> educationLevels = {
    'OL': 0,
    'AL': 1,
    'UNI': 2,
  };

  // Grade mappings - Display letters but store percentages
  static const Map<String, double> grades = {
    'A': 85.0,
    'B': 65.0,
    'C': 55.0,
    'S': 45.0,
    'F': 35.0,
  };

  static const double GRADE_NOT_SET = 0.0;

  // AL Streams
  static const Map<String, int> alStreams = {
    'Physical Science': 6,
    'Biological Science': 7,
    'Physical Science with ICT': 8,
    'Bio Science with Agriculture': 9,
  };

  // Required subjects for each level
  static const List<String> requiredOLSubjects = [
    'Maths',
    'Science',
    'English',
    'Sinhala',
    'History',
    'Religion'
  ];

  // AL Stream subject mappings
  static Map<int, List<String>> streamSubjects = {
    6: ['Physics', 'Chemistry', 'Combined_Maths'],
    7: ['Biology', 'Chemistry', 'Physics'],
    8: ['Combined_Maths', 'Physics', 'ICT'],
    9: ['Biology', 'Chemistry', 'Agriculture'],
  };

  // Helper method to get grade letter from percentage
  static String? getGradeLetter(double percentage) {
    if (percentage == GRADE_NOT_SET) return null;
    return grades.entries
        .firstWhere((entry) => entry.value == percentage,
            orElse: () => const MapEntry('', 0.0))
        .key;
  }
}
