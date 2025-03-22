// import 'package:eg/config/mapp_config.dart';
// import 'package:flutter/material.dart';
// import '../../models/students/assignments_model.dart';
// import '../../services/students/assignments_service.dart';
// import '../../utils/constants.dart';


// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:url_launcher/url_launcher.dart';

// class StuAssignments extends StatefulWidget {
//   const StuAssignments({super.key});

//   @override
//   State<StuAssignments> createState() => _StuAssignmentsState();
// }

// class _StuAssignmentsState extends State<StuAssignments> {
//   late Future<List<Assignment>> _assignments;
//   final AssignmentService _service = AssignmentService(
//     accessToken: AppConfig.accessToken,
//   );

//   @override
//   void initState() {
//     super.initState();
//     _assignments = _service.fetchAssignments();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Assignments', style: TextStyle(color: Colors.white),),
//         backgroundColor: AppConstants.mainColor,
//       ),
//       body: FutureBuilder<List<Assignment>>(
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
//                 String date = assignment.dueDate.split('T')[0];
//                 String time = assignment.dueDate.split('T')[1];
//                 time = time.substring(0, time.length - 1);

//                 DateTime dueDateTime = DateTime.parse(assignment.dueDate);
// bool isOverdue = dueDateTime.isBefore(DateTime.now());

// return Card(
//   elevation: 4,
//   child: ListTile(
//     title: Text(assignment.title),
//     subtitle: Text(
//       'Due Date: $date $time',
//       style: TextStyle(color: isOverdue ? Colors.red : Colors.black),
//     ),
//     trailing: const Icon(Icons.arrow_forward),
//     onTap: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => AssignmentDetailPage(assignment: assignment),
//         ),
//       );
//     },
//   ),
// );

//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class AssignmentDetailPage extends StatelessWidget {
//   final Assignment assignment;

//   const AssignmentDetailPage({super.key, required this.assignment});

  

//   @override
//   Widget build(BuildContext context) {
//     String date = assignment.dueDate.split('T')[0];
//     String time = assignment.dueDate.split('T')[1];
//     time = time.substring(0, time.length - 1);

//     DateTime dueDateTime = DateTime.parse(assignment.dueDate);
//     bool isOverdue = dueDateTime.isBefore(DateTime.now());

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(assignment.title),
//         backgroundColor: AppConstants.mainColor,
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
//             Text('Subject: ${assignment.subject}'),
//             Text('Marks: ${assignment.mark}'),
//             Text(
//               'Due Date: $date $time',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: isOverdue ? Colors.red : Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Display image if available
//             if (assignment.image != null)
//               GestureDetector(
//                 onTap: () => _openFullScreenImage(context, assignment.image!),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.network(
//                     assignment.image!,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             const SizedBox(height: 10),

//             // Open document button if available
//             if (assignment.document != null)
//               ElevatedButton.icon(
//                 onPressed: () => _openDocument(assignment.document!),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppConstants.mainColor,
//                 ),
//                 icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
//                 label: const Text(
//                   'Open Document',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             const SizedBox(height: 10),

//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppConstants.mainColor,
//                 elevation: 5,
//               ),
//               child: const Text(
//                 'Upload assignment',
//                 style: TextStyle(fontSize: 16, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _openFullScreenImage(BuildContext context, String imageUrl) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FullScreenImage(imageUrl: imageUrl),
//       ),
//     );
//   }

//   void _openDocument(String documentUrl) async {
//     if (await canLaunchUrl(Uri.parse(documentUrl))) {
//       await launchUrl(Uri.parse(documentUrl), mode: LaunchMode.externalApplication);
//     } else {
//       debugPrint("Could not open document.");
//     }
//   }
// }

// class FullScreenImage extends StatelessWidget {
//   final String imageUrl;

//   const FullScreenImage({super.key, required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//       ),
//       body: Center(
//         child: PhotoView(
//           imageProvider: NetworkImage(imageUrl),
//           backgroundDecoration: const BoxDecoration(color: Colors.black),
//         ),
//       ),
//     );
//   }
// }

//-------------------------------------------------------
// import 'package:eg/config/mapp_config.dart';
// import 'package:eg/screens/students/submission.dart';
// import 'package:flutter/material.dart';
// import '../../models/students/assignments_model.dart';
// import '../../services/students/assignments_service.dart';
// import '../../utils/constants.dart';

// import 'package:photo_view/photo_view.dart';
// import 'package:url_launcher/url_launcher.dart';

// class StuAssignments extends StatefulWidget {
//   const StuAssignments({super.key});

//   @override
//   State<StuAssignments> createState() => _StuAssignmentsState();
// }

// class _StuAssignmentsState extends State<StuAssignments> {
//   late Future<List<Assignment>> _assignments;
//   final AssignmentService _service = AssignmentService(
//     accessToken: AppConfig.accessToken,
//   );

//   @override
//   void initState() {
//     super.initState();
//     _assignments = _service.fetchAssignments();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Assignments', style: TextStyle(color: Colors.white)),
//         backgroundColor: AppConstants.mainColor,
//       ),
//       body: FutureBuilder<List<Assignment>>(
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
//                 String date = assignment.dueDate.split('T')[0];
//                 String time = assignment.dueDate.split('T')[1].split('.')[0];

//                 DateTime dueDateTime = DateTime.parse(assignment.dueDate);
//                 bool isOverdue = dueDateTime.isBefore(DateTime.now());

//                 return Card(
//                   elevation: 4,
//                   margin: const EdgeInsets.only(bottom: 16),
//                   child: Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           assignment.title,
//                           style: const TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 5),
//                         Text('Subject: ${assignment.subject}'),
//                         Text('Marks: ${assignment.mark}'),
//                         Text(
//                           'Due Date: $date $time',
//                           style: TextStyle(
//                             color: isOverdue ? Colors.red : Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 10),

//                         // Display image if available
//                         if (assignment.image != null)
//                           GestureDetector(
//                             onTap: () => _openFullScreenImage(
//                                 context, assignment.image!),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Image.network(
//                                 assignment.image!,
//                                 height: 200,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         const SizedBox(height: 10),

//                         // Open document button if available
//                         if (assignment.document != null)
//                           ElevatedButton.icon(
//                             onPressed: () => _openDocument(assignment.document!),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppConstants.mainColor,
//                             ),
//                             icon: const Icon(Icons.picture_as_pdf,
//                                 color: Colors.white),
//                             label: const Text(
//                               'Open Document',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         const SizedBox(height: 10),

//                         ElevatedButton(
//                           onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => AssignmentSubmissionPage(assignmentId: assignment.id, accessToken: AppConfig.accessToken,),
//                           ),
//                         );
//                       },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppConstants.mainColor,
//                             elevation: 5,
//                           ),
//                           child: const Text(
//                             'Upload assignment',
//                             style: TextStyle(fontSize: 16, color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }

//   void _openFullScreenImage(BuildContext context, String imageUrl) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FullScreenImage(imageUrl: imageUrl),
//       ),
//     );
//   }

//   void _openDocument(String documentUrl) async {
//     if (await canLaunchUrl(Uri.parse(documentUrl))) {
//       await launchUrl(Uri.parse(documentUrl),
//           mode: LaunchMode.externalApplication);
//     } else {
//       debugPrint("Could not open document.");
//     }
//   }
// }

// class FullScreenImage extends StatelessWidget {
//   final String imageUrl;

//   const FullScreenImage({super.key, required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//       ),
//       body: Center(
//         child: PhotoView(
//           imageProvider: NetworkImage(imageUrl),
//           backgroundDecoration: const BoxDecoration(color: Colors.black),
//         ),
//       ),
//     );
//   }
// }


import 'package:eg/config/mapp_config.dart';
import 'package:eg/screens/students/submission.dart';
import 'package:flutter/material.dart';
import '../../models/students/assignments_model.dart';
import '../../services/students/assignments_service.dart';
import '../../utils/constants.dart';

import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class StuAssignments extends StatefulWidget {
  const StuAssignments({super.key});

  @override
  State<StuAssignments> createState() => _StuAssignmentsState();
}

class _StuAssignmentsState extends State<StuAssignments> {
  late Future<List<Assignment>> _assignments;
  final AssignmentService _service = AssignmentService(
    accessToken: AppConfig.accessToken,
  );

  @override
  void initState() {
    super.initState();
    _assignments = _service.fetchAssignments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppConstants.mainColor,
        elevation: 0,
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
                String date = assignment.dueDate.split('T')[0];
                String time = assignment.dueDate.split('T')[1].split('.')[0];

                DateTime dueDateTime = DateTime.parse(assignment.dueDate);
                bool isOverdue = dueDateTime.isBefore(DateTime.now());

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black26,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Assignment Title
                        Text(
                          assignment.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Subject & Marks
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subject: ${assignment.subject}',
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Marks: ${assignment.mark}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppConstants.mainColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),

                        // Due Date
                        Text(
                          'Due Date: $date $time',
                          style: TextStyle(
                            color: isOverdue ? Colors.red : Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Image Preview
                        if (assignment.image != null)
                          GestureDetector(
                            onTap: () => _openFullScreenImage(
                                context, assignment.image!),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Image.network(
                                  assignment.image!,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 12),

                        // Open Document Button
                        if (assignment.document != null)
                          ElevatedButton.icon(
                            onPressed: () => _openDocument(assignment.document!),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstants.mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 3,
                            ),
                            icon: const Icon(Icons.picture_as_pdf,
                                color: Colors.white),
                            label: const Text(
                              'Open Document',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        const SizedBox(height: 12),

                        // Upload Assignment Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AssignmentSubmissionPage(
                                  assignmentId: assignment.id,
                                  accessToken: AppConfig.accessToken,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstants.mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 4,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Upload Assignment',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _openFullScreenImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(imageUrl: imageUrl),
      ),
    );
  }

  void _openDocument(String documentUrl) async {
    if (await canLaunchUrl(Uri.parse(documentUrl))) {
      await launchUrl(Uri.parse(documentUrl),
          mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not open document.");
    }
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          backgroundDecoration: const BoxDecoration(color: Colors.black),
        ),
      ),
    );
  }
}
