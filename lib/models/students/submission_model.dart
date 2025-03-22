// class AssignmentSubmission {
//   final String assignment;
//   final String? image;
//   final String? document;

//   AssignmentSubmission({
//     required this.assignment,
//     this.image,
//     this.document,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       "assignment": assignment,
//       "image": image,
//       "document": document,
//     };
//   }
// }
import 'dart:typed_data';

class AssignmentSubmission {
  final String assignmentId;
  final Uint8List? imageBytes;
  final String? imageName;
  final Uint8List? documentBytes;
  final String? documentName;

  AssignmentSubmission({
    required this.assignmentId,
    this.imageBytes,
    this.imageName,
    this.documentBytes,
    this.documentName,
  });

  Map<String, dynamic> toJson() {
    return {
      "assignment": assignmentId,
      "image": imageName, 
      "document": documentName, 
    };
  }
}
