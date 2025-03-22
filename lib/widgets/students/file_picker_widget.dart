import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerWidget extends StatelessWidget {
  final String fileType;
  final Function(Uint8List?, String?) onFileSelected;

  FilePickerWidget({required this.fileType, required this.onFileSelected});

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: fileType == "image" ? FileType.image : FileType.custom,
      allowedExtensions: fileType == "document" ? ['pdf', 'doc', 'docx'] : null,
      withData: true, // Needed for Web
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      onFileSelected(file.bytes, file.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: pickFile,
          icon: Icon(Icons.upload_file),
          label: Text("Select $fileType"),
        ),
      ],
    );
  }
}
