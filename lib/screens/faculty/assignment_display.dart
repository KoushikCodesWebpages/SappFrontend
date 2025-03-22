import 'package:eg/config/mapp_config.dart';
import 'package:eg/screens/faculty/assignments.dart';
import 'package:flutter/material.dart';
import '../../models/students/assignments_model.dart';
import '../../services/students/assignments_service.dart';
import '../../utils/constants.dart';

import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class FacAssignmentsDisplay extends StatefulWidget {
  const FacAssignmentsDisplay({super.key});

  @override
  State<FacAssignmentsDisplay> createState() => _FacAssignmentsDisplayState();
}

class _FacAssignmentsDisplayState extends State<FacAssignmentsDisplay> {
  late Future<List<Assignment>> _assignments;
  final AssignmentService _service = AssignmentService(
    accessToken: AppConfig.accessToken,
  );

  @override
  void initState() {
    super.initState();
    _assignments = _service.fetchAssignments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments', style: TextStyle(color: Colors.white)),
        backgroundColor: AppConstants.mainColor,
      ),
      body: FutureBuilder<List<Assignment>>(
        future: _assignments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No assignments available.'));
          } else {
            final assignments = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: assignments.length,
              itemBuilder: (context, index) {
                final assignment = assignments[index];
                String date = assignment.dueDate.split('T')[0];
                String time = assignment.dueDate.split('T')[1].split('.')[0];

                DateTime dueDateTime = DateTime.parse(assignment.dueDate);
                bool isOverdue = dueDateTime.isBefore(DateTime.now());

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          assignment.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text('Subject: ${assignment.subject}'),
                        Text('Marks: ${assignment.mark}'),
                        Text(
                          'Due Date: $date $time',
                          style: TextStyle(
                            color: isOverdue ? Colors.red : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Display image if available
                        if (assignment.image != null)
                          GestureDetector(
                            onTap: () => _openFullScreenImage(
                                context, assignment.image!),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                assignment.image!,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),

                        // Open document button if available
                        if (assignment.document != null)
                          ElevatedButton.icon(
                            onPressed: () => _openDocument(assignment.document!),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstants.mainColor,
                            ),
                            icon: const Icon(Icons.picture_as_pdf,
                                color: Colors.white),
                            label: const Text(
                              'Open Document',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        const SizedBox(height: 10),

                        ElevatedButton(
                          onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FacAssignments(),
                          ),
                        );
                      },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstants.mainColor,
                            elevation: 5,
                          ),
                          child: const Text(
                            'Upload new assignment',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _openFullScreenImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(imageUrl: imageUrl),
      ),
    );
  }

  void _openDocument(String documentUrl) async {
    if (await canLaunchUrl(Uri.parse(documentUrl))) {
      await launchUrl(Uri.parse(documentUrl),
          mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not open document.");
    }
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          backgroundDecoration: const BoxDecoration(color: Colors.black),
        ),
      ),
    );
  }
}
