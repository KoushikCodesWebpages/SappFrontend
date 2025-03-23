import 'package:flutter/material.dart';
import '../../utils/constants.dart'; 

class StudentDetailsPage extends StatelessWidget {
  final Map<String, dynamic> studentData;

  const StudentDetailsPage({super.key, required this.studentData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.mainColor.withOpacity(0.1),
      appBar: AppBar(
        title: Text(
          studentData["user"]["username"],
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppConstants.mainColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileAvatar(),
            const SizedBox(height: 20),
            _buildUserDetailsCard(),
          ],
        ),
      ),
    );
  }

  /// Profile Avatar with elegant styling
  Widget _buildProfileAvatar() {
    return Center(
      child: CircleAvatar(
        radius: 60,
        backgroundColor: AppConstants.mainColor.withOpacity(0.1),
        backgroundImage: studentData["image"] != null ? NetworkImage(studentData["image"]) : null,
        child: studentData["image"] == null
            ? const Icon(Icons.person, size: 60, color: Colors.grey)
            : null,
      ),
    );
  }

  /// User details wrapped inside a Card for a structured look
  Widget _buildUserDetailsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Username", studentData["user"]["username"]),
            _buildDetailRow("Email", studentData["user"]["email"]),
          ],
        ),
      ),
    );
  }

  /// Styled row for displaying student details
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 18, color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
