import 'package:eg/config/mapp_config.dart';
import 'package:eg/screens/faculty/assignment_display.dart';
import 'package:eg/screens/faculty/dashboard.dart';
import 'package:eg/screens/faculty/results.dart';
import 'package:eg/screens/faculty/subjects.dart';
import 'package:flutter/material.dart';
import 'package:eg/screens/students/assignments.dart';
import 'package:eg/screens/students/results.dart';
import 'package:eg/screens/students/timetable.dart';
import 'students/dashboard.dart';
import '../utils/constants.dart';
import 'dart:io';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = AppConstants.roleController == "student"
      ? <Widget>[
          const DashboardScreen(),
          StuTimetableScreen(accessToken: AppConfig.accessToken),
          const StuAssignments(),
          StuResults(),
        ]
      : <Widget>[
          const FacDashboard(),
          const SubjectsPage(),
          FacAssignmentsDisplay(),
          FacultyResultsPage(accessToken: AppConfig.accessToken),
        ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exitApp = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Do you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: const Text('Exit'),
              ),
            ],
          ),
        );
        return exitApp;
      },
      child: Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6, offset: const Offset(0, -2)),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: AppConstants.mainColor,
            unselectedItemColor: Colors.blueGrey,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            elevation: 6,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard,
                    color: _selectedIndex == 0 ? AppConstants.mainColor : Colors.blueGrey),
                label: 'Dashboard',
              ),
              AppConstants.roleController == "student"
                  ? BottomNavigationBarItem(
                      icon: Icon(Icons.book,
                          color: _selectedIndex == 1 ? AppConstants.mainColor : Colors.blueGrey),
                      label: 'Timetable',
                    )
                  : BottomNavigationBarItem(
                      icon: Icon(Icons.people_alt,
                          color: _selectedIndex == 1 ? AppConstants.mainColor : Colors.blueGrey),
                      label: 'Subjects',
                    ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment,
                    color: _selectedIndex == 2 ? AppConstants.mainColor : Colors.blueGrey),
                label: 'Assignments',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school,
                    color: _selectedIndex == 3 ? AppConstants.mainColor : Colors.blueGrey),
                label: 'Results',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    )
    );
  }
}
