import 'package:flutter/material.dart';
import '../services/notifications_service.dart';
import '../models/notifications_model.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  NotificationsPageState createState() => NotificationsPageState();
}

class NotificationsPageState extends State<NotificationsPage> {
  final NotificationsService _mailService = NotificationsService();
  List<Mail> mails = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMails();
  }

  Future<void> fetchMails() async {
    final fetchedMails = await _mailService.fetchMails();
    setState(() {
      mails = fetchedMails;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : mails.isEmpty
                ? const Center(child: Text('No notifications available.'))
                : ListView.builder(
                    itemCount: mails.length,
                    itemBuilder: (context, index) {
                      final mail = mails[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          title: Text(mail.subject),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(mail.body),
                              const SizedBox(height: 8),
                              Text(
                                'From: ${mail.sender}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'Date: ${mail.date}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

void main() {
  runApp(const NotificationsPage());
}
