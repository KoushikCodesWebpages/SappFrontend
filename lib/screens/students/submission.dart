import 'package:flutter/material.dart';
import '../../models/students/submission_model.dart';
import '../../services/students/submission_service.dart';
import 'dart:typed_data';
import '../../widgets/students/file_picker_widget.dart';
import '../../utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AssignmentSubmissionPage extends StatefulWidget {
  final String assignmentId;
  final String accessToken;

  const AssignmentSubmissionPage({super.key, required this.assignmentId, required this.accessToken});

  @override
  AssignmentSubmissionPageState createState() => AssignmentSubmissionPageState();
}

class AssignmentSubmissionPageState extends State<AssignmentSubmissionPage> {
  Uint8List? imageBytes;
  String? imageName;
  Uint8List? documentBytes;
  String? documentName;
  String? submittedImageUrl;
  String? submittedDocumentUrl;
  bool hasSubmitted = false;

  final AssignmentService _assignmentService = AssignmentService();

  @override
  void initState() {
    super.initState();
    _fetchSubmission();
  }

  Future<void> _fetchSubmission() async {
    List<dynamic> submissions = await _assignmentService.getSubmissions(widget.accessToken, widget.assignmentId);
    var filteredSubmissions = submissions.where((submission) => submission["assignment"] == widget.assignmentId).toList();

    if (filteredSubmissions.isNotEmpty) {
      var latestSubmission = filteredSubmissions.last; // Assuming last is the latest

      setState(() {
        hasSubmitted = true;
        submittedImageUrl = latestSubmission["image"];
        submittedDocumentUrl = latestSubmission["document"];
      });
    } else {
      setState(() {
        hasSubmitted = false;
        submittedImageUrl = null;
        submittedDocumentUrl = null;
      });
    }
  }

  Future<void> submitAssignment() async {
    if (imageBytes == null && documentBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select either an image or a document.")),
      );
      return;
    }

    AssignmentSubmission submission = AssignmentSubmission(
      assignmentId: widget.assignmentId,
      imageBytes: imageBytes,
      imageName: imageName,
      documentBytes: documentBytes,
      documentName: documentName,
    );

    bool success = await _assignmentService.submitAssignment(
      widget.accessToken,
      submission.toJson(),
      submission.imageBytes,
      submission.imageName,
      submission.documentBytes,
      submission.documentName,
    );

    if (success) {
      _fetchSubmission(); // Refresh to show submitted files
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? "Submission Successful!" : "Submission Failed!"),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  Future<void> _openPDF() async {
    final Uri url = Uri.parse(submittedDocumentUrl!);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $submittedDocumentUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Submit Assignment", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppConstants.mainColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasSubmitted) ...[
              const Text(
                "Already Submitted",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              if (submittedImageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    submittedImageUrl!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 10),

              if (submittedDocumentUrl != null)
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _openPDF,
                    icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                    label: const Text("View Submitted Document", style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
            ] else ...[
              // Image Picker
              FilePickerWidget(
                fileType: "image",
                onFileSelected: (bytes, name) {
                  setState(() {
                    imageBytes = bytes;
                    imageName = name;
                  });
                },
              ),
              if (imageName != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Selected: $imageName",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
                  ),
                ),
              const SizedBox(height: 16),

              // Document Picker
              FilePickerWidget(
                fileType: "document",
                onFileSelected: (bytes, name) {
                  setState(() {
                    documentBytes = bytes;
                    documentName = name;
                  });
                },
              ),
              if (documentName != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Selected: $documentName",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
                  ),
                ),
              const SizedBox(height: 20),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: hasSubmitted ? null : submitAssignment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: hasSubmitted ? Colors.grey : AppConstants.mainColor,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
