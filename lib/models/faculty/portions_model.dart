class Portion {
  String standard;
  String academicYear;
  String subject;
  List<String> unit;
  List<String> title;
  String? image;
  String? document;
  String description;
  String reference;
  String lastUpdated;

  Portion({
    required this.standard,
    required this.academicYear,
    required this.subject,
    required this.unit,
    required this.title,
    this.image,
    this.document,
    required this.description,
    required this.reference,
    required this.lastUpdated,
  });

  Map<String, dynamic> toJson() {
    return {
      "standard": standard,
      "academic_year": academicYear,
      "subject": subject,
      "unit": unit,
      "title": title,
      "image": image,
      "document": document,
      "description": description,
      "reference": reference,
      "last_updated": lastUpdated,
    };
  }
}
