class Mail {
  final int mailId;
  final String subject;
  final String sender;
  final String recipient;
  final String date;
  final String body;

  Mail({
    required this.mailId,
    required this.subject,
    required this.sender,
    required this.recipient,
    required this.date,
    required this.body,
  });

  factory Mail.fromJson(Map<String, dynamic> json) {
    return Mail(
      mailId: json['mail_id'],
      subject: json['subject'],
      sender: json['sender'],
      recipient: json['recipient'],
      date: json['date'],
      body: json['body'],
    );
  }
}
