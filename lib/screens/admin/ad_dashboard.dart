import 'package:flutter/material.dart';
import 'ad_profile.dart'; // Import the profile page

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  bool isSidebarOpen = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 800;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _buildAppBar(isDesktop),
        body: Row(
          children: [
            if (isSidebarOpen || isDesktop) _buildSidebar(isDesktop),
            Expanded(child: _buildMainContent()),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(bool isDesktop) {
    return AppBar(
      backgroundColor: const Color(0xFF4A90E2),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (!isDesktop)
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      isSidebarOpen = !isSidebarOpen;
                    });
                  },
                ),
              const Text(
                "Admin Dashboard",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.email, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to the profile page when the image is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdProfile()),
                  );
                },
                child: const CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                ),
              ),
              const SizedBox(width: 10),
              if (isDesktop)
                const Text(
                  "Admin User",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(bool isDesktop) {
    List<Map<String, dynamic>> items = [
      {'icon': Icons.school, 'title': 'Students'},
      {'icon': Icons.group, 'title': 'Staff Members'},
      {'icon': Icons.calendar_today, 'title': 'Calendar'},
      {'icon': Icons.announcement, 'title': 'Announcements'},
      {'icon': Icons.lock, 'title': 'Result Lock'},
      {'icon': Icons.lock_clock, 'title': 'Attendance Lock'},
      {'icon': Icons.notifications, 'title': 'Notifications'},
      {'icon': Icons.report_problem, 'title': 'Complaint Box'},
      {'icon': Icons.access_time, 'title': 'Timetable'},
      {'icon': Icons.assignment, 'title': 'Assignments'},
      {'icon': Icons.bar_chart, 'title': 'Performance Reports'}
    ];
    return Container(
      width: isDesktop ? 250 : 200,
      color: const Color(0xFF4A90E2),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: items.map((item) {
                return ListTile(
                  leading: Icon(item['icon'], color: Colors.white),
                  title: Text(item['title'],
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white)),
                  onTap: () {},
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Admin Dashboard Overview",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              children: [
                // Responsive Cards Row
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Adjust the number of columns based on available width
                      int crossAxisCount = 1;
                      if (constraints.maxWidth > 1200) {
                        crossAxisCount = 4; // For large screens
                      } else if (constraints.maxWidth > 800) {
                        crossAxisCount = 3; // For medium screens
                      } else if (constraints.maxWidth > 500) {
                        crossAxisCount = 2; // For small screens
                      }

                      return GridView.count(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.5,
                        children: [
                          _buildDashboardCard(
                            title: "Total Students",
                            count: "1,500",
                            icon: Icons.person,
                            color: Colors.blueAccent,
                          ),
                          _buildDashboardCard(
                            title: "Teacher Available",
                            count: "120",
                            icon: Icons.assignment,
                            color: Colors.orangeAccent,
                          ),
                          _buildDashboardCard(
                            title: "Performance Report",
                            count: "5",
                            icon: Icons.security,
                            color: Colors.redAccent,
                          ),
                          _buildDashboardCard(
                            title:"New Notices",
                            count: "5",
                            icon: Icons.healing,
                            color: Colors.greenAccent,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard({
    required String title,
    required String count,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Text(
            count,
            style: const TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
