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
  
  static final List<Widget> _pages = <Widget>[
    const DashboardScreen(),
    const StuTimetable(), //Portions
    const StuAssignments(),
    const StuResults(),
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Portions'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Assignment',),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Result'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
