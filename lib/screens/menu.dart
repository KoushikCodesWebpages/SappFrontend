import 'package:eg/screens/admin/calendar.dart';
import 'package:eg/screens/admin/complaint.dart';
import 'package:eg/screens/admin/faculty_db.dart';
import 'package:eg/screens/admin/results.dart';
import 'package:eg/screens/admin/student_db.dart';
import 'package:eg/screens/admin/timetable.dart';
import 'package:eg/screens/complaint.dart';
import 'package:eg/screens/faculty/assignments.dart';
import 'package:eg/screens/faculty/attendance.dart';
import 'package:eg/screens/faculty/dashboard.dart';
import 'package:eg/screens/faculty/payments.dart';
import 'package:eg/screens/faculty/results.dart';
import 'package:eg/screens/faculty/subjects.dart';
import 'package:eg/screens/notifications.dart';
import 'package:eg/screens/profile.dart';
import 'package:eg/screens/settings.dart';
import 'package:eg/screens/students/assignments.dart';
import 'package:eg/screens/students/attendance.dart';
import 'package:eg/screens/students/dashboard.dart';
import 'package:eg/screens/students/payments.dart';
import 'package:eg/screens/students/results.dart';
import 'package:eg/screens/students/subjects.dart';
import 'package:eg/screens/students/timetable.dart';
import 'package:flutter/material.dart';
import '../widgets/elev_button.dart';
import '../config/mapp_config.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      width: 500,
      height: 800,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Students:", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20,),
            ElevButton(name: "Assignments", className: StuAssignments()),
            SizedBox(height: 10,),
            ElevButton(name: "Attendance", className: StuAttendance()),
            SizedBox(height: 10,),
            ElevButton(name: "Dashboard", className: DashboardScreen()),
            SizedBox(height: 10,),
            ElevButton(name: "Payments", className: StuPayments()),
            SizedBox(height: 10,),
            ElevButton(name: "Results", className: StuResults()),
            SizedBox(height: 10,),
            ElevButton(name: "Subjects", className: StuSubjects()),
            SizedBox(height: 10,),
            ElevButton(name: "Timetable", className: StuTimetable())
          ],
        ),
        SizedBox(width: 10,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Faculty:", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20,),
            ElevButton(name: "Assignments", className: FacAssignments()),
            SizedBox(height: 10,),
            ElevButton(name: "Attendance", className: FacAttendance()),
            SizedBox(height: 10,),
            ElevButton(name: "Dashboard", className: FacDashboard()),
            SizedBox(height: 10,),
            ElevButton(name: "Payments", className: FacPayments()),
            SizedBox(height: 10,),
            ElevButton(name: "Results", className: FacResults()),
            SizedBox(height: 10,),
            ElevButton(name: "Subjects", className: FacSubjects()),
          ],
        ),
        SizedBox(width: 10,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Admin:", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20,),
            ElevButton(name: "Calendar", className: AdminCalendar()),
            SizedBox(height: 10,),
            ElevButton(name: "Complaint Box", className: AdminComplaint()),
            SizedBox(height: 10,),
            ElevButton(name: "Faculty Database", className: AdminFacDB()),
            SizedBox(height: 10,),
            ElevButton(name: "Results", className: AdminResults()),
            SizedBox(height: 10,),
            ElevButton(name: "Student Database", className: AdminStuDb()),
            SizedBox(height: 10,),
            ElevButton(name: "Timetable", className: AdminTT())
          ],
        ),
        const SizedBox(width: 10,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Common for all:", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20,),
            ElevButton(name: "Complaint Box", className: ComplaintPage()),
            SizedBox(height: 10,),
            ElevButton(name: "Notifications", className: NotificationsPage()),
            SizedBox(height: 10,),
            ElevButton(name: "Profile", className: ProfilePage(accessToken: AppConfig.accessToken)),
            SizedBox(height: 10,),
            ElevButton(name: "Settings", className: SettingsPage()),
          ],
        ),
      ],
    )
    );
  }
}