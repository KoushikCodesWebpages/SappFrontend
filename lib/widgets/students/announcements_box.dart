// import 'package:flutter/material.dart';
// import '../../models/students/announcements_model.dart';
// import '../../services/students/announcements_service.dart';
// import '../../utils/constants.dart';

// class AnnouncementWidget extends StatefulWidget {
//   const AnnouncementWidget({super.key});

//   @override
//   AnnouncementWidgetState createState() => AnnouncementWidgetState();
// }

// class AnnouncementWidgetState extends State<AnnouncementWidget> {
//   AnnouncementService announcementService = AnnouncementService();
//   Announcement? announcement;

//   @override
//   void initState() {
//     super.initState();
//     loadAnnouncement();
//   }

//   Future<void> loadAnnouncement() async {
//   var fetchedAnnouncements = await announcementService.fetchAnnouncements();
//   setState(() {
//     // Take the first announcement if the list is not empty
//     announcement = (fetchedAnnouncements != null && fetchedAnnouncements.isNotEmpty) 
//       ? fetchedAnnouncements.first 
//       : null;
//   });
// }


//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       color: AppConstants.mainColor,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Container(
//           constraints: BoxConstraints(
//             maxWidth: 500,
//           ),
//         child: announcement == null
//             //? const Center(child: CircularProgressIndicator())
//             ?Text("No announcements right now",style: TextStyle(fontSize: 20, color: Colors.white),)
//             : Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.campaign, color: Colors.red),
//                 SizedBox(width: 8),
//                 Text(
//                   announcement!.title,
//                   style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
//                 ),
//               ]
//             ),
//             SizedBox(height: 8),
//             Text("Date: ${announcement!.date}\nTimings: ${announcement!.timings}", style: TextStyle(color: Colors.white)),
//             Row(
//               children: [
//                 SizedBox(width: 2,),
//                 Spacer(),
//                 TextButton(
//                   onPressed: () {}, 
//                   child: Text('See previous', style: TextStyle(color: Colors.white),)
//                 ),
//               ],
//             ),
//             SizedBox(height: 8),
//           ],
//         ),
//         )
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../models/students/announcements_model.dart';
import '../../services/students/announcements_service.dart';
import '../../utils/constants.dart';

class AnnouncementWidget extends StatefulWidget {
  const AnnouncementWidget({super.key});

  @override
  AnnouncementWidgetState createState() => AnnouncementWidgetState();
}

class AnnouncementWidgetState extends State<AnnouncementWidget> {
  AnnouncementService announcementService = AnnouncementService();
  Announcement? announcement;

  @override
  void initState() {
    super.initState();
    loadAnnouncement();
  }

  Future<void> loadAnnouncement() async {
    var fetchedAnnouncements = await announcementService.fetchAnnouncements();
    setState(() {
      // Take the first announcement if available
      announcement = (fetchedAnnouncements != null && fetchedAnnouncements.isNotEmpty) 
          ? fetchedAnnouncements.first 
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [AppConstants.mainColor, Colors.blue.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        constraints: BoxConstraints(maxWidth: 500),
        child: announcement == null
            ? Center(
                child: Text(
                  "No announcements right now",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.campaign, color: Colors.redAccent, size: 28),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          announcement!.title,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    "📅 Date: ${announcement!.date}\n🕒 Timings: ${announcement!.timings}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'See previous',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
