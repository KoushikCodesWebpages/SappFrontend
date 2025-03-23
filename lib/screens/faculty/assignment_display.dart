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
      backgroundColor: AppConstants.mainColor.withOpacity(0.1),
      appBar: AppBar(
        title: const Text('Assignments', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppConstants.mainColor,
        elevation: 3,
      ),
      body: FutureBuilder<List<Assignment>>(
        future: _assignments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'No assignments available.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                _uploadAssignmentButton(context),
              ],
            );
          } else {
            final assignments = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: assignments.length,
                    itemBuilder: (context, index) {
                      final assignment = assignments[index];
                      String date = assignment.dueDate.split('T')[0];
                      String time = assignment.dueDate.split('T')[1].split('.')[0];

                      DateTime dueDateTime = DateTime.parse(assignment.dueDate);
                      bool isOverdue = dueDateTime.isBefore(DateTime.now());

                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                assignment.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Subject: ${assignment.subject}',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Text(
                                'Marks: ${assignment.mark}',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              Text(
                                'Due Date: $date $time',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isOverdue ? Colors.red : AppConstants.mainColor,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Display image if available
                              if (assignment.image != null)
                                InkWell(
                                  onTap: () => _openFullScreenImage(context, assignment.image!),
                                  borderRadius: BorderRadius.circular(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      assignment.image!,
                                      height: 200,
                                      width: double.infinity,
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
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 3,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                                  label: const Text(
                                    'Open Document',
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                _uploadAssignmentButton(context),
              ],
            );
          }
        },
      ),
    );
  }

  // Upload assignment button (always visible)
  Widget _uploadAssignmentButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => FacAssignments(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: const Text(
          ' Upload New Assignment ',
          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
      await launchUrl(Uri.parse(documentUrl), mode: LaunchMode.externalApplication);
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
