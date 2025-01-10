import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main/components/side_menu.dart';
import 'package:flutter_application_1/screens/main/dashboard/dashboard_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sidebar or navigation area
            Expanded(
              child: SideMenu(),
            ),
            // Main content area
            Expanded(
              flex: 5, // Adjust the flex ratio as per your layout requirements
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
