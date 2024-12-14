class Institution {
  final String id;
  final String name;
  final String type;
  final String website;
  final String location;
  final Map<String, String> contactInfo;

  Institution({
    required this.id,
    required this.name,
    required this.type,
    required this.website,
    required this.location,
    required this.contactInfo,
  });

  factory Institution.fromJson(Map<String, dynamic> json) {
    return Institution(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      website: json['website'],
      location: json['location'],
      contactInfo: Map<String, String>.from(json['contactInfo']),
    );
  }
}
