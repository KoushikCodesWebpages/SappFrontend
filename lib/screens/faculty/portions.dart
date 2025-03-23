import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../services/faculty/portions_service.dart';
import '../../widgets/faculty/file_picker_widget.dart';
import '../../utils/constants.dart'; // Assuming you have this file for colors.

class PostPortionScreen extends StatefulWidget {

  const PostPortionScreen({super.key});

  @override
  PostPortionScreenState createState() => PostPortionScreenState();
}

class PostPortionScreenState extends State<PostPortionScreen> {
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
      backgroundColor: Colors.white, // Background color
      appBar: AppBar(
        title: const Text("Post Portion", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: AppConstants.mainColor,
        foregroundColor: Colors.white,
        //centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextField(standardController, "Standard"),
                  _buildTextField(academicYearController, "Academic Year"),
                  _buildTextField(subjectController, "Subject"),
                  _buildTextField(unitController, "Units (comma separated)"),
                  _buildTextField(titleController, "Titles (comma separated)"),
                  _buildTextField(descriptionController, "Description", maxLines: 3),
                  _buildTextField(referenceController, "Reference"),
                  const SizedBox(height: 16),

                  // File Picker Widgets
                  _buildSectionTitle("Upload Image"),
                  FilePickerWidget(fileType: "image", onFileSelected: (bytes, name) {
                    setState(() {
                      imageBytes = bytes;
                      imageName = name;
                    });
                  }),

                  const SizedBox(height: 16),
                  _buildSectionTitle("Upload Document"),
                  FilePickerWidget(fileType: "document", onFileSelected: (bytes, name) {
                    setState(() {
                      docBytes = bytes;
                      docName = name;
                    });
                  }),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: submitPortion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppConstants.mainColor.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppConstants.mainColor, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppConstants.mainColor,
        ),
      ),
    );
  }
}
