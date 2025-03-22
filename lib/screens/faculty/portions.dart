import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../services/faculty/portions_service.dart';
import '../../widgets/faculty/file_picker_widget.dart';

class PostPortionScreen extends StatefulWidget {
  @override
  _PostPortionScreenState createState() => _PostPortionScreenState();
}

class _PostPortionScreenState extends State<PostPortionScreen> {
  final TextEditingController standardController = TextEditingController();
  final TextEditingController academicYearController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();
  
  Uint8List? imageBytes;
  String? imageName;
  Uint8List? docBytes;
  String? docName;

  final PortionService portionService = PortionService();

  Future<void> submitPortion() async {
    Map<String, dynamic> portionData = {
      "standard": standardController.text,
      "academic_year": academicYearController.text,
      "subject": subjectController.text,
      "unit": unitController.text.split(','), 
      "title": titleController.text.split(','),
      "description": descriptionController.text,
      "reference": referenceController.text,
      "last_updated": DateTime.now().toIso8601String(),
    };

    bool success = await portionService.postPortion(portionData, imageBytes, imageName, docBytes, docName);
    
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(success ? "Portion posted successfully!" : "Failed to post portion."),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Portion")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: standardController, decoration: InputDecoration(labelText: "Standard")),
            TextField(controller: academicYearController, decoration: InputDecoration(labelText: "Academic Year")),
            TextField(controller: subjectController, decoration: InputDecoration(labelText: "Subject")),
            TextField(controller: unitController, decoration: InputDecoration(labelText: "Units (comma separated)")),
            TextField(controller: titleController, decoration: InputDecoration(labelText: "Titles (comma separated)")),
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: "Description")),
            TextField(controller: referenceController, decoration: InputDecoration(labelText: "Reference")),

            FilePickerWidget(fileType: "image", onFileSelected: (bytes, name) {
              setState(() {
                imageBytes = bytes;
                imageName = name;
              });
            }),

            FilePickerWidget(fileType: "document", onFileSelected: (bytes, name) {
              setState(() {
                docBytes = bytes;
                docName = name;
              });
            }),

            SizedBox(height: 20),
            ElevatedButton(onPressed: submitPortion, child: Text("Submit")),
          ],
        ),
      ),
    );
  }
}
