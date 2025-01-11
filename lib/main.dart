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
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/my-courses': (context) => const EmptyPage(title: 'My Courses'),
        '/dashboard': (context) => const EmptyPage(title: 'Dashboard'),
        '/payment-info': (context) => const EmptyPage(title: 'Payment Info'),
        '/attendance': (context) => const EmptyPage(title: 'Attendance'),
        '/calendar': (context) => const EmptyPage(title: 'Calendar'),
        '/result': (context) => const EmptyPage(title: 'Result'),
        '/profile': (context) => const EmptyPage(title: 'Profile'),
        '/account-settings': (context) => const EmptyPage(title: 'Account Settings'),
        '/notification': (context) => const EmptyPage(title: 'Notification'),
      },
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
      drawer: SizedBox(
        width: 250, // Set the desired width of the sidebar
        child: Drawer(
          child: Container(
            color: const Color(0xFF948EE8), // Sidebar background color
            child: Column(
              children: [
                // Sidebar Navigation Bar (Header)
                Container(
                  color: const Color(0xFF948EE8), // Match the sidebar background color
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.school, // Graduation cap icon
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'SchoolCamp',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.book, color: Colors.white),
                        title: const Text('My Courses', style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.pushNamed(context, '/my-courses');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.dashboard, color: Colors.white),
                        title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.pushNamed(context, '/dashboard');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.payment, color: Colors.white),
                        title: const Text('Payment Info', style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.pushNamed(context, '/payment-info');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.check_circle, color: Colors.white),
                        title: const Text('Attendance', style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.pushNamed(context, '/attendance');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.calendar_today, color: Colors.white),
                        title: const Text('Calendar', style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.pushNamed(context, '/calendar');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.bar_chart, color: Colors.white),
                        title: const Text('Result', style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.pushNamed(context, '/result');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.person, color: Colors.white),
                        title: const Text('Profile', style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.settings, color: Colors.white),
                      title: const Text('Account Settings', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pushNamed(context, '/account-settings');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.notifications, color: Colors.white),
                      title: const Text('Notification', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pushNamed(context, '/notification');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.exit_to_app, color: Colors.white),
                      title: const Text('Logout', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                // Bottom Margin with Sidebar Color
                Container(
                  height: 20.0, // Adjust the height of the margin
                  color: const Color(0xFF948EE8), // Same color as the sidebar
                ),
              ],
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

class EmptyPage extends StatelessWidget {
  final String title;

  const EmptyPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('This is the $title page'),
      ),
    );
  }
}
