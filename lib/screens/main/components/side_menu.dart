import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: secondayColor, // Set the background color to green
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Drawer Header with School Name
            DrawerHeader(
              decoration: BoxDecoration(
                color: secondayColor, // Set the background color
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.school, size: 40, color: secondayColor),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "School Name", // Replace with your school's name
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 24, // Font size for the title
                      fontWeight: FontWeight.bold, // Bold text style
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Admin", // User Role (e.g. Admin or User)
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Drawer List Items
            DrawerListTile(
                title: "Dashboard", icon: Icons.dashboard, press: () {}),
            DrawerListTile(
                title: "Student Management", icon: Icons.person, press: () {}),
            DrawerListTile(
                title: "Teacher Management",
                icon: Icons.person_outline,
                press: () {}),
            DrawerListTile(
                title: "Fee Management", icon: Icons.money, press: () {}),
            DrawerListTile(
                title: "Library Management",
                icon: Icons.library_books,
                press: () {}),
            DrawerListTile(
                title: "Reports and Analytics",
                icon: Icons.analytics,
                press: () {}),
            DrawerListTile(
                title: "Settings", icon: Icons.settings, press: () {}),

            // Logout Button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  // Add logout functionality
                },
                leading: Icon(Icons.exit_to_app, color: Colors.red),
                title: Text(
                  "Logout",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        color: bgColor,
        size: 20,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: bgColor,
          fontSize: 16,
          fontWeight: FontWeight.w500, // Style title text with weight
        ),
      ),
    );
  }
}
