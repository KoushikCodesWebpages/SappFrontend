import 'package:eg/config/mapp_config.dart';
import 'package:eg/screens/faculty/assignments.dart';
import 'package:eg/screens/faculty/dashboard.dart';
import 'package:eg/screens/faculty/results.dart';
import 'package:eg/screens/faculty/subjects.dart';
import 'package:flutter/material.dart';
import 'package:eg/screens/students/assignments.dart';
import 'package:eg/screens/students/results.dart';
import 'package:eg/screens/students/timetable.dart';
import 'dashboard.dart';
import '../../utils/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  
  static final List<Widget> _pages = AppConstants.roleController=="student"? <Widget>[
    const DashboardScreen(),
    StuTimetableScreen(accessToken:  AppConfig.accessToken), //Portions
    const StuAssignments(),
    StuResults(),
  ] : <Widget>[
    const FacDashboard(),
    const SubjectsPage(),
    const FacAssignments(),
    const FacResults()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        fit: StackFit.loose,
        children: [
          Positioned.fill(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: AppConstants.mainColor,
        unselectedItemColor: AppConstants.mainColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          AppConstants.roleController=="student"? BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Portions') : BottomNavigationBarItem(icon: Icon(Icons.people_alt), label: 'Class Details'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Assignment',),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Result'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
