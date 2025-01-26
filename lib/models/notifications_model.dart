class Mail {
  final String subject;
  final String body;
  final String sender;
  final String date;

  Mail({
    required this.subject,
    required this.body,
    required this.sender,
    required this.date,
  });

  // Factory method to create a Mail object from a JSON map
  factory Mail.fromJson(Map<String, dynamic> json) {
    return Mail(
      subject: json['subject'] as String,
      body: json['body'] as String,
      sender: json['sender'] as String,
      date: json['date'] as String,
    );
  }
}
