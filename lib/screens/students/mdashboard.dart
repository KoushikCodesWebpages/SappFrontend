import 'package:eg/screens/notifications.dart';
import 'package:eg/screens/profile.dart';
import 'package:eg/utils/constants.dart';
import 'package:flutter/material.dart';
import '../../widgets/students/mstu_details.dart';
import '../../widgets/students/mstu_announcements.dart';
import '../../widgets/students/mstu_calendar.dart';

class DashboardScreen extends StatelessWidget {
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
                  builder: (context) => ProfilePage(),
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
            StudentDetailsWidget(),
            SizedBox(height: 16),
            AnnouncementWidget(),
            SizedBox(height: 16),
            CalendarWidget(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppConstants.mainColor,
        items: const [
          BottomNavigationBarItem(backgroundColor: AppConstants.mainColor,icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(backgroundColor: AppConstants.mainColor,icon: Icon(Icons.book), label: 'Portions'),
          BottomNavigationBarItem(backgroundColor: AppConstants.mainColor,icon: Icon(Icons.assignment), label: 'Assignment'),
          BottomNavigationBarItem(backgroundColor: AppConstants.mainColor,icon: Icon(Icons.school), label: 'Result'),
        ],
      ),
    );
  }
}
