// import 'package:flutter/material.dart';
// import '../../services/students/assignments_service.dart';

// class StuAssignments extends StatefulWidget {
//   const StuAssignments({super.key});

//   @override
//   State<StuAssignments> createState() => _StuAssignmentsState();
// }

// class _StuAssignmentsState extends State<StuAssignments> {
//   late Future<List<StuAssignmentsService>> _assignments;

//   @override
//   void initState() {
//     super.initState();
//     _assignments = AssignmentService().fetchAssignments();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Assignments'),
//         backgroundColor: Colors.blue,
//       ),
//       body: FutureBuilder<List<StuAssignmentsService>>(
//         future: _assignments,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No assignments available.'));
//           } else {
//             final assignments = snapshot.data!;
//             return ListView.builder(
//               padding: const EdgeInsets.all(16.0),
//               itemCount: assignments.length,
//               itemBuilder: (context, index) {
//                 final assignment = assignments[index];
//                 return Card(
//                   elevation: 4,
//                   child: ListTile(
//                     title: Text(assignment.title),
//                     subtitle: Text('Due Date: ${assignment.dueDate}'),
//                     trailing: const Icon(Icons.arrow_forward),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => AssignmentDetailPage(assignment: assignment),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class AssignmentDetailPage extends StatelessWidget {
//   final StuAssignmentsService assignment;

//   const AssignmentDetailPage({super.key, required this.assignment});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(assignment.title),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               assignment.title,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'Description:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//             ),
//             Text(
//               assignment.description,
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Submission Deadline:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//             ),
//             Text(
//               assignment.dueDate,
//               style: const TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:eg/utils/constants.dart';
import 'package:flutter/material.dart';

class StuAssignments extends StatefulWidget {
  const StuAssignments({super.key});

  @override
  State<StuAssignments> createState() => _StuAssignmentsState();
}

class _StuAssignmentsState extends State<StuAssignments> {
  late Future<List<Assignment>> _assignments;

  @override
  void initState() {
    super.initState();
    _assignments = fetchSimulatedAssignments();
  }

  Future<List<Assignment>> fetchSimulatedAssignments() async {
    return Future.delayed(const Duration(seconds: 1), () {
      return [
        Assignment(
          title: "Math Homework",
          description: "Solve 10 algebra problems from chapter 3.",
          dueDate: "2025-02-10",
        ),
        Assignment(
          title: "Science Project",
          description: "Prepare a model on renewable energy sources.",
          dueDate: "2025-02-15",
        ),
        Assignment(
          title: "History Assignment",
          description: "Write an essay on the Industrial Revolution.",
          dueDate: "2025-02-12",
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
        backgroundColor: AppConstants.mainColor,
      ),
      body: FutureBuilder<List<Assignment>>(
        future: _assignments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No assignments available.'));
          } else {
            final assignments = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: assignments.length,
              itemBuilder: (context, index) {
                final assignment = assignments[index];
                return Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text(assignment.title),
                    subtitle: Text('Due Date: ${assignment.dueDate}'),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AssignmentDetailPage(assignment: assignment),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Assignment {
  final String title;
  final String description;
  final String dueDate;

  Assignment({required this.title, required this.description, required this.dueDate});
}

class AssignmentDetailPage extends StatelessWidget {
  final Assignment assignment;

  const AssignmentDetailPage({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(assignment.title),
        backgroundColor: AppConstants.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              assignment.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              assignment.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Submission Deadline:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              assignment.dueDate,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
