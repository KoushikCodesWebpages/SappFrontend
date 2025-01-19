import 'package:flutter/material.dart';
import '../../services/students/stu_dashboard_service.dart';
import './stu_assignments.dart';
import './stu_attendance.dart';
import './stu_payments.dart';
import './stu_results.dart';
import './stu_subjects.dart';
import '../profile.dart';
import '../settings.dart';
import '../notifications.dart';

class StuDashboard extends StatefulWidget {
  const StuDashboard({super.key});

  @override
  State<StuDashboard> createState() => _StuDashboardState();
}

class _StuDashboardState extends State<StuDashboard> {
  final StuDashboardService _studentService = StuDashboardService();
  List<Map<String, dynamic>> studentData = [];
  bool isSidebarOpen = true;

  @override
  void initState() {
    super.initState();
    _fetchStudentData();
  }

  Future<void> _fetchStudentData() async {
    try {
      final data = await _studentService.fetchStudentData();
      setState(() {
        studentData = data;
      });
    } catch (e) {
      print("Error fetching student data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 800;

    return MaterialApp(
      home: Scaffold(
        appBar: _buildAppBar(isDesktop),
        body: Row(
          children: [
            if (isSidebarOpen || isDesktop) _buildSidebar(isDesktop),
            Expanded(child: _buildMainContent(isDesktop)),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(bool isDesktop) {
    return AppBar(
      backgroundColor: const Color(0xFF759BFC),
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
                "School Camp",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              if (isDesktop) _buildSearchBar(),
              const SizedBox(width: 20),
              IconButton(icon: const Icon(Icons.email, color: Colors.white), onPressed: () {}),
              const SizedBox(width: 10),
              IconButton(icon: const Icon(Icons.notifications, color: Colors.white), onPressed: () {}),
              const SizedBox(width: 10),
              const CircleAvatar(backgroundImage: NetworkImage('https://via.placeholder.com/150')),
              const SizedBox(width: 10),
              if (isDesktop)
                const Text("John Doe", style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 40,
      width: 300,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          contentPadding: EdgeInsets.all(10),
        ),
      ),
    );
  }

  Widget _buildSidebar(bool isDesktop) {
    List<Map<String, dynamic>> items = [
      {'icon': Icons.dashboard, 'title': 'Dashboard', 'page': const StuDashboard()},
      {'icon': Icons.book, 'title': 'My Subjects', 'page': const StuSubjects()},
      {'icon': Icons.payment, 'title': 'Payment Info', 'page': const StuPayments()},
      {'icon': Icons.check_circle, 'title': 'Attendance', 'page': const StuAttendance()},
      {'icon': Icons.assignment, 'title': 'Assignment', 'page': const StuAssignments()},
      {'icon': Icons.calendar_today, 'title': 'Calendar'},
      {'icon': Icons.bar_chart, 'title': 'Result', 'page': const StuResults()},
      {'icon': Icons.person, 'title': 'Profile', 'page': const ProfilePage()},
      {'icon': Icons.settings, 'title': 'Account Settings', 'page': const SettingsPage()},
      {'icon': Icons.notifications, 'title': 'Notification Preferences', 'page': const NotificationsPage()},
      {'icon': Icons.logout, 'title': 'Logout'},
    ];

    return Container(
      width: isDesktop ? 250 : 200,
      color: const Color(0xFF759BFC),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: items.map((item) {
          return ListTile(
            leading: Icon(item['icon'], color: Colors.white),
            title: Text(item['title'], style: const TextStyle(fontSize: 16, color: Colors.white)),
            onTap: () {
              if (item['page'] != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => item['page']));
              }
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMainContent(bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Student Details',
            style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 3 : 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 3 / 2,
              ),
              itemCount: studentData.length,
              itemBuilder: (context, index) {
                return _buildStudentCard(studentData[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentCard(Map<String, dynamic> student) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF759BFC),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${student['name']}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 10),
            Text("Email: ${student['email']}", style: const TextStyle(fontSize: 14, color: Colors.white)),
            const SizedBox(height: 5),
            Text("Grade: ${student['grade']}", style: const TextStyle(fontSize: 14, color: Colors.white)),
            const SizedBox(height: 5),
            Text("Age: ${student['age']}", style: const TextStyle(fontSize: 14, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}