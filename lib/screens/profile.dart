import 'package:eg/config/mapp_config.dart';
import 'package:flutter/material.dart';
import '../services/profile_service.dart';
import '../models/profile_model.dart';

class ProfilePage extends StatefulWidget {
  final String accessToken;

  const ProfilePage({super.key, required this.accessToken});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late Future<UserProfile> _futureUserProfile;

  @override
  void initState() {
    super.initState();
    _futureUserProfile = ProfileService(apiUrl: AppConfig.profileUrl)
        .fetchUserProfile(widget.accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: FutureBuilder<UserProfile>(
        future: _futureUserProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final userProfile = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Username: ${userProfile.username}'),
                  Text('Email: ${userProfile.email}'),
                  Text('Role: ${userProfile.role}'),
                  Text('Enrollment Number: ${userProfile.enrollmentNumber}'),
                  Text('Standard: ${userProfile.standard}'),
                  Text('Section: ${userProfile.section}'),
                  Text('Subjects: ${userProfile.subjects.join(', ')}'),
                  Text('Academic Year: ${userProfile.academicYear}'),
                  Text('Attendance: ${userProfile.attendancePercent}%'),
                  Text('Student Code: ${userProfile.studentCode}'),
                ],
              ),
            );
          }
          return Center(child: Text('No data found'));
        },
      ),
    );
  }
}
