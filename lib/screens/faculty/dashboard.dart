import 'package:eg/config/mapp_config.dart';
import 'package:eg/screens/notifications.dart';
import 'package:eg/screens/students/profile.dart';
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
      appBar: AppBar(
        title: Text('Sapp', style: TextStyle(color: Colors.white)),
        backgroundColor: AppConstants.mainColor,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications), 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationsPage(),
                ),
              );
            }
          ),
          IconButton(
            icon: Icon(Icons.person), 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(accessToken: AppConfig.accessToken,),
                ),
              );
            }
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
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
}
