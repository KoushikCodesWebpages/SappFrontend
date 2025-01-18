import 'package:eg/screens/admin/ad_calendar.dart';
import 'package:eg/screens/admin/ad_complaint.dart';
import 'package:eg/screens/admin/ad_faculty_db.dart';
import 'package:eg/screens/admin/ad_results.dart';
import 'package:eg/screens/admin/ad_student_db.dart';
import 'package:eg/screens/admin/ad_timetable.dart';
import 'package:eg/screens/faculty/fac_assignments.dart';
import 'package:eg/screens/faculty/fac_attendance.dart';
import 'package:eg/screens/faculty/fac_dashboard.dart';
import 'package:eg/screens/faculty/fac_payments.dart';
import 'package:eg/screens/faculty/fac_results.dart';
import 'package:eg/screens/faculty/fac_subjects.dart';
import 'package:eg/screens/students/stu_assignments.dart';
import 'package:eg/screens/students/stu_attendance.dart';
import 'package:eg/screens/students/stu_dashboard.dart';
import 'package:eg/screens/students/stu_payments.dart';
import 'package:eg/screens/students/stu_results.dart';
import 'package:eg/screens/students/stu_subjects.dart';
import 'package:eg/screens/students/stu_timetable.dart';
import 'package:flutter/material.dart';
import '../widgets/elev_button.dart';

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
            ElevButton(name: "Dashboard", className: StuDashboard()),
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
      ],
    )
    );
  }
}