class EducationConfig {
  static const Map<int, String> educationLevels = {
    1: 'O/L',
    2: 'A/L',
    3: 'University',
  };

  static const Map<String, int> olSubjects = {
    'Mathematics': 0,
    'Science': 1,
    'English': 2,
    'Sinhala': 3,
    'History': 4,
    'Religion': 5,
  };

  static const defaultStream = 6;

  static const Map<int, String> alStreams = {
    6: 'Physical Science',
    7: 'Biological Science', 
    8: 'Physical Science with ICT',
    9: 'Bio Science with Agriculture',
  };

  static const Map<String, List<String>> streamSubjects = {
    'Physical Science': ['Combined Mathematics', 'Physics', 'Chemistry'],
    'Biological Science': ['Biology', 'Chemistry', 'Physics'],
    'Physical Science with ICT': ['Combined Mathematics', 'Physics', 'ICT'],
    'Bio Science with Agriculture': ['Biology', 'Chemistry', 'Agriculture'],
  };
}