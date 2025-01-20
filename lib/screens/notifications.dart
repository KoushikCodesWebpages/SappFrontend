import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<dynamic> mails = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMails();
  }

  Future<void> fetchMails() async {
    const String apiUrl = 'http://127.0.0.1:5007/mail';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          mails = data['mails'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load mails');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching mails: $e');
    }
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
                          title: Text(mail['subject']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(mail['body']),
                              const SizedBox(height: 8),
                              Text(
                                'From: ${mail['sender']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'Date: ${mail['date']}',
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
