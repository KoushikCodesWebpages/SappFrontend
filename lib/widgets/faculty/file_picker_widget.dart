import 'dart:io' if (dart.library.html) 'dart:html' as html;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class FilePickerWidget extends StatefulWidget {
  final Function(Uint8List?, String?) onFileSelected;
  final String fileType;

  const FilePickerWidget({Key? key, required this.onFileSelected, required this.fileType}) : super(key: key);

  @override
  _FilePickerWidgetState createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  String? fileName;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: widget.fileType == "image" ? FileType.image : FileType.any,
      withData: true, // Ensures bytes are available for web
    );

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
      });

      Uint8List? fileBytes = result.files.single.bytes;
      widget.onFileSelected(fileBytes, fileName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: pickFile,
          child: Text("Pick ${widget.fileType}"),
        ),
        if (fileName != null) Text("Selected: $fileName"),
      ],
    );
  }
}
