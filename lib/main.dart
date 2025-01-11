import 'package:flutter/material.dart';
import 'assignment_page.dart'; // Import the Assignment Page file

void main() {
  runApp(SchoolApp());
}

class SchoolApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('School App')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: const Color.fromARGB(255, 121, 36, 190)),
              child: Text(
                'Menu',
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Assignment'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AssignmentPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(child: Text('School App')),
    );
  }
}
