import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SchoolCamp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SchoolCamp'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFF948EE8), // Sidebar background color set to #948ee8
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Add margin with same color as sidebar
            child: Container(
              color: const Color(0xFF948EE8), // Match the margin color with the sidebar color
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.book, color: Colors.white),
                          title: const Text('My Courses', style: TextStyle(color: Colors.white)),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.dashboard, color: Colors.white),
                          title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.payment, color: Colors.white),
                          title: const Text('Payment Info', style: TextStyle(color: Colors.white)),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.check_circle, color: Colors.white),
                          title: const Text('Attendance', style: TextStyle(color: Colors.white)),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.calendar_today, color: Colors.white),
                          title: const Text('Calendar', style: TextStyle(color: Colors.white)),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.bar_chart, color: Colors.white),
                          title: const Text('Result', style: TextStyle(color: Colors.white)),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.person, color: Colors.white),
                          title: const Text('Profile', style: TextStyle(color: Colors.white)),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.settings, color: Colors.white),
                        title: const Text('Account Settings', style: TextStyle(color: Colors.white)),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.notifications, color: Colors.white),
                        title: const Text('Notification Preference', style: TextStyle(color: Colors.white)),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.exit_to_app, color: Colors.white),
                        title: const Text('Logout', style: TextStyle(color: Colors.white)),
                        onTap: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: const Center(
        child: Text('SchoolCamp'),
      ),
    );
  }
}
