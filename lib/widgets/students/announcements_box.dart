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
    var fetchedAnnouncement = await announcementService.fetchAnnouncement();
    setState(() {
      announcement = fetchedAnnouncement;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: AppConstants.mainColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 500,
          ),
        child: announcement == null
            //? const Center(child: CircularProgressIndicator())
            ?Text("No announcements right now",style: TextStyle(fontSize: 20, color: Colors.white),)
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.campaign, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  announcement!.title,
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ]
            ),
            SizedBox(height: 8),
            Text("Date: ${announcement!.date}\nTimings: ${announcement!.timings}", style: TextStyle(color: Colors.white)),
            Row(
              children: [
                SizedBox(width: 2,),
                Spacer(),
                TextButton(
                  onPressed: () {}, 
                  child: Text('See previous', style: TextStyle(color: Colors.white),)
                ),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
        )
      ),
    );
  }
}