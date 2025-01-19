import 'package:eg/screens/profile.dart';
import 'package:eg/screens/settings.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './stu_assignments.dart';
import './stu_attendance.dart';
import './stu_payments.dart';
import './stu_results.dart';
import './stu_subjects.dart';
import '../notifications.dart';
class StuDashboard extends StatefulWidget {
  const StuDashboard({super.key});

  @override
  State<StuDashboard> createState() => _StuDashboardState();
}

class _StuDashboardState extends State<StuDashboard> {
  bool isSidebarOpen = true;
  List<dynamic> studentData = [];

  @override
  void initState() {
    super.initState();
    fetchStudentData();
  }

  Future<void> fetchStudentData() async {
    const String apiUrl = "http://127.0.0.1:5013/students";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          studentData = data['students'];
        });
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 800;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (isDesktop)
                    Container(
                      height: 40,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.email, color: Colors.white),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 10),
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150',
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (isDesktop)
                    const Text(
                      "John Doe",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                ],
              ),
            ],
          ),
        ),
        body: Row(
          children: [
            if (isSidebarOpen || isDesktop)
              Container(
                width: isDesktop ? 250 : 200,
                color: const Color(0xFF759BFC),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        children: _buildSidebarItems(),
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Student Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
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
                          return _buildCard(studentData[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSidebarItems() {
    List<Map<String, dynamic>> items = [
      {'icon': Icons.dashboard, 'title': 'Dashboard','page':StuDashboard()},
      {'icon': Icons.book, 'title': 'My Subjects','page':StuSubjects()},
      {'icon': Icons.payment, 'title': 'Payment Info','page':StuPayments()},
      {'icon': Icons.check_circle, 'title': 'Attendance','page':StuAttendance()},
      {'icon': Icons.assignment, 'title': 'Assignment','page':StuAssignments()},
      {'icon': Icons.calendar_today, 'title': 'Calendar'},//if (calendar) page update then update the function here
      {'icon': Icons.bar_chart, 'title': 'Result','page':StuResults()},
      {'icon': Icons.person, 'title': 'Profile','page':ProfilePage()},
      {'icon': Icons.settings, 'title': 'Account Settings','page':SettingsPage()},
      {'icon': Icons.notifications, 'title': 'Notification Preferences','page':NotificationsPage()},
      {'icon': Icons.logout, 'title': 'Logout'},//if (logout) page update then update the function here
    ];
    return items.map(
      (item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: ListTile(
            leading: Icon(item['icon'], color: Colors.white),
            title: Text(
              item['title'],
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => item['page']),
            );
            },
          ),
        );
      },
    ).toList();
  }

  Widget _buildCard(Map<String, dynamic> student) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
         color: Color(0xFF759BFC),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name: ${student['name']}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Email: ${student['email']}",
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              "Grade: ${student['grade']}",
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              "Age: ${student['age']}",
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const StuDashboard());
}
