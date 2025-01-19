import 'package:flutter/material.dart';

class StuAssignments extends StatelessWidget {
  const StuAssignments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
        backgroundColor: Colors.blue, // Match the color scheme with the app's theme
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Example assignment previews
          Card(
            elevation: 4,
            child: ListTile(
              title: const Text('Assignment 1'),
              subtitle: const Text('Due Date: 2025-01-20'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to the detailed assignment view
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AssignmentDetailPage(title: 'Assignment 1')),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 4,
            child: ListTile(
              title: const Text('Assignment 2'),
              subtitle: const Text('Due Date: 2025-01-25'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AssignmentDetailPage(title: 'Assignment 2')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AssignmentDetailPage extends StatelessWidget {
  final String title;

  const AssignmentDetailPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const Text(
              'This is the detailed description of the assignment. Include all relevant instructions and details here.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Submission Deadline:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const Text(
              '2025-01-20',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
