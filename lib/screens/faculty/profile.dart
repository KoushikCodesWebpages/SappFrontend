import 'package:eg/utils/constants.dart';
import 'package:eg/widgets/elev_button.dart';
import 'package:flutter/material.dart';
import '../../services/faculty/profile_service.dart';
import '../../models/faculty/profile_model.dart';

class ProfilePage extends StatefulWidget {
  final String accessToken;

  const ProfilePage({super.key, required this.accessToken});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late Future<FacProfile> _futureUserProfile;

  @override
  void initState() {
    super.initState();
    _futureUserProfile = ProfileService()
        .fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: AppConstants.mainColor,
        elevation: 4.0,
      ),
      body: FutureBuilder<FacProfile>(
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
              child: ListView(
                children: [
                  // Profile Avatar
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      //backgroundImage: NetworkImage(userProfile.profileImage ?? 'https://example.com/default_avatar.png'),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Profile Details
                  Card(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProfileInfo('Username', userProfile.username, Icons.person),
                          _buildProfileInfo('Email', userProfile.email, Icons.email),
                          _buildProfileInfo('Role', userProfile.role, Icons.work),
                          _buildProfileInfo('Faculty ID', userProfile.facultyId, Icons.school),
                          _buildProfileInfo('Department', userProfile.department, Icons.grade),
                          _buildProfileInfo('Specialization', userProfile.specialization, Icons.assignment),
                          //_buildProfileInfo('Coverage', userProfile.coverage.join(', '), Icons.book),
                          //_buildProfileInfo('Class Teacher', userProfile.classTeacher.join(', '), Icons.calendar_today),
                          _buildProfileInfo(
  'Coverage', 
  userProfile.coverage.map((c) => c.join(' - ')).join('\n'), 
  Icons.book,
),
                          _buildProfileInfo(
  'Class Teacher', 
  userProfile.classTeacher.join(' - '), 
  Icons.calendar_today,
),
//_buildProfileInfo('Attendance', '${userProfile.attendancePercent}%', Icons.check_circle),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
    //               ElevatedButton(
    //   child: Text("Edit Profile"),
    //   onPressed: (){
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => EditProfile(),
    //       ),
    //     );
    //   },
    // )   //Change the alignment
                ],
              ),
            );
          }
          return Center(child: Text('No data found'));
        },
      ),
    );
  }

  // A helper method to build each profile info section
  Widget _buildProfileInfo(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppConstants.mainColor),
          SizedBox(width: 10),
          Expanded(child: 
          Text(
            '$title: $value',
            softWrap: true,
            maxLines: null,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          )
        ],
      ),
    );
  }
}
