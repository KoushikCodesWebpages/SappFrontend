class Portion {
  final String id;
  final String standard;
  final String academicYear;
  final String subject;
  final List<String> units;
  final List<String> titles;
  final String description;
  final String reference;
  final String? image;
  final String? document;
  final String lastUpdated;

  Portion({
    required this.id,
    required this.standard,
    required this.academicYear,
    required this.subject,
    required this.units,
    required this.titles,
    required this.description,
    required this.reference,
    this.image,
    this.document,
    required this.lastUpdated,
  });

  factory Portion.fromJson(Map<String, dynamic> json) {
    return Portion(
      id: json["id"],
      standard: json["standard"],
      academicYear: json["academic_year"],
      subject: json["subject"],
      units: List<String>.from(json["unit"]),
      titles: List<String>.from(json["title"]),
      description: json["description"],
      reference: json["reference"],
      image: json["image"],
      document: json["document"],
      lastUpdated: json["last_updated"],
    );
  }
}
