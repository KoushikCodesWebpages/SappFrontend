import 'package:eg/config/mapp_config.dart';
import 'package:eg/screens/notifications.dart';
import 'package:eg/screens/faculty/profile.dart';
import 'package:eg/utils/constants.dart';
import 'package:flutter/material.dart';
import '../../widgets/faculty/dashboard_details.dart';
import '../../widgets/students/announcements_box.dart';
import '../../widgets/students/calendar.dart';

class FacDashboard extends StatefulWidget {
  const FacDashboard({super.key});
  @override
  FacDashboardState createState() => FacDashboardState();
}

class FacDashboardState extends State<FacDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.mainColor.withOpacity(0.1),
      appBar: AppBar(
        title: const Text(
          'Sapp',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        backgroundColor: AppConstants.mainColor,
        actions: [
          _buildIconButton(Icons.notifications, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationsPage()),
            );
          }),
          _buildIconButton(Icons.person, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage(accessToken: AppConfig.accessToken)),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FacultyCard(),
            SizedBox(height: 16),
            Text(" Announcements",style: TextStyle(fontSize: 19, color: Colors.black, fontWeight: FontWeight.bold),),
            SizedBox(height: 7,),
            AnnouncementWidget(),
            SizedBox(height: 16),
            Text(" Calendar",style: TextStyle(fontSize: 19, color: Colors.black, fontWeight: FontWeight.bold),),
            SizedBox(height: 7,),
            CalendarScreen(),
          ],
        ),
      ),
    );
  }

  /// Reusable method for icon buttons in AppBar
  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, color: Colors.white, size: 26),
      onPressed: onPressed,
    );
  }
}
