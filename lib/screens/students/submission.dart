import 'package:flutter/material.dart';
import '../../models/students/submission_model.dart';
import '../../services/students/submission_service.dart';
import 'dart:typed_data';
import '../../widgets/students/file_picker_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/pdf_viewer_page.dart';

class AssignmentSubmissionPage extends StatefulWidget {
  final String assignmentId;
  final String accessToken;

  AssignmentSubmissionPage({required this.assignmentId, required this.accessToken});

  @override
  _AssignmentSubmissionPageState createState() => _AssignmentSubmissionPageState();
}

class _AssignmentSubmissionPageState extends State<AssignmentSubmissionPage> {
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

    if (submissions.isNotEmpty) {
      var latestSubmission = submissions.last; // Assuming last is the latest

      setState(() {
        hasSubmitted = true;
        submittedImageUrl = latestSubmission["image"];
        submittedDocumentUrl = latestSubmission["document"];
      });
    }
  }

  Future<void> submitAssignment() async {
    if (imageBytes == null && documentBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select either an image or a document.")),
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
      SnackBar(content: Text(success ? "Submission Successful!" : "Submission Failed!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Submit Assignment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (hasSubmitted) ...[
              Text("Already Submitted:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              if (submittedImageUrl != null) Image.network(submittedImageUrl!),
              if (submittedDocumentUrl != null)
                TextButton(
  //                 onPressed: () {
  //   if (submittedDocumentUrl != null) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => PDFViewerPage(pdfUrl: submittedDocumentUrl!),
  //       ),
  //     );
  //   }
  // },
  onPressed: () {
    if (submittedDocumentUrl != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewerPage(pdfUrl: submittedDocumentUrl!),
        ),
      );
    }
  },
  //                 onPressed: () async {
  //   if (submittedDocumentUrl != null) {
  //     final Uri url = Uri.parse(submittedDocumentUrl!);
  //     if (await canLaunchUrl(url)) {
  //       await launchUrl(url, mode: LaunchMode.externalApplication);
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Could not open document.")),
  //       );
  //     }
  //   }
  // },
                  child: Text("View Submitted Document"),
                ),
              SizedBox(height: 20),
            ] else ...[
              FilePickerWidget(fileType: "image", onFileSelected: (bytes, name) {
                setState(() {
                  imageBytes = bytes;
                  imageName = name;
                });
              }),
              FilePickerWidget(fileType: "document", onFileSelected: (bytes, name) {
                setState(() {
                  documentBytes = bytes;
                  documentName = name;
                });
              }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: hasSubmitted ? null : submitAssignment, // Disable if already submitted
                child: Text("Submit"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
