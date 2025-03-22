// import 'package:eg/utils/constants.dart';
// import 'package:eg/widgets/elev_button.dart';
// import 'package:flutter/material.dart';
// import '../../services/students/profile_service.dart';
// import '../../models/students/profile_model.dart';
// import 'edit_profile.dart';

// class ProfilePage extends StatefulWidget {
//   final String accessToken;

//   const ProfilePage({super.key, required this.accessToken});

//   @override
//   ProfilePageState createState() => ProfilePageState();
// }

// class ProfilePageState extends State<ProfilePage> {
//   late Future<UserProfile> _futureUserProfile;

//   @override
//   void initState() {
//     super.initState();
//     _futureUserProfile = ProfileService()
//         .fetchUserProfile();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         backgroundColor: AppConstants.mainColor,
//         elevation: 4.0,
//       ),
//       body: FutureBuilder<UserProfile>(
//         future: _futureUserProfile,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             final userProfile = snapshot.data!;
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ListView(
//                 children: [
//                   // Profile Avatar
//                   Center(
//                     child: CircleAvatar(
//                       radius: 50,
//                       //backgroundImage: NetworkImage(userProfile.profileImage ?? 'https://example.com/default_avatar.png'),
//                     ),
//                   ),
//                   SizedBox(height: 20),

//                   // Profile Details
//                   Card(
//                     elevation: 3.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildProfileInfo('Username', userProfile.username, Icons.person),
//                           _buildProfileInfo('Email', userProfile.email, Icons.email),
//                           _buildProfileInfo('Role', userProfile.role, Icons.work),
//                           _buildProfileInfo('Enrollment Number', userProfile.enrollmentNumber, Icons.school),
//                           _buildProfileInfo('Standard', userProfile.standard.toString(), Icons.grade),
//                           _buildProfileInfo('Section', userProfile.section, Icons.assignment),
//                           _buildProfileInfo('Subjects', userProfile.subjects.join(', '), Icons.book),
//                           _buildProfileInfo('Academic Year', userProfile.academicYear, Icons.calendar_today),
//                           _buildProfileInfo('Attendance', '${userProfile.attendancePercent}%', Icons.check_circle),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 5,),
//     //               ElevatedButton(
//     //   child: Text("Edit Profile"),
//     //   onPressed: (){
//     //     Navigator.push(
//     //       context,
//     //       MaterialPageRoute(
//     //         builder: (context) => EditProfile(),
//     //       ),
//     //     );
//     //   },
//     // )   //Change the alignment
//                 ],
//               ),
//             );
//           }
//           return Center(child: Text('No data found'));
//         },
//       ),
//     );
//   }

//   // A helper method to build each profile info section
//   Widget _buildProfileInfo(String title, String value, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Icon(icon, color: AppConstants.mainColor),
//           SizedBox(width: 10),
//           Expanded(child: 
//           Text(
//             '$title: $value',
//             softWrap: true,
//             maxLines: null,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           )
//         ],
//       ),
//     );
//   }
// }



import 'package:eg/utils/constants.dart';
import 'package:flutter/material.dart';
import '../../services/students/profile_service.dart';
import '../../models/students/profile_model.dart';

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
    _futureUserProfile = ProfileService().fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Clean white background
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppConstants.mainColor,  // Deep blue header
        elevation: 4.0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<UserProfile>(
        future: _futureUserProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ));
          } else if (snapshot.hasData) {
            final userProfile = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // Profile Avatar with border
                  Center(
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: AppConstants.mainColor,  // Blue border
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          //userProfile.profileImage ??
                              'https://example.com/default_avatar.png',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Profile Details Card
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProfileInfo(
                              'Username', userProfile.username, Icons.person),
                          _buildProfileInfo(
                              'Email', userProfile.email, Icons.email),
                          _buildProfileInfo(
                              'Role', userProfile.role, Icons.work),
                          _buildProfileInfo('Enrollment Number',
                              userProfile.enrollmentNumber, Icons.school),
                          _buildProfileInfo('Standard',
                              userProfile.standard.toString(), Icons.grade),
                          _buildProfileInfo(
                              'Section', userProfile.section, Icons.assignment),
                          _buildProfileInfo(
                              'Subjects',
                              userProfile.subjects.join(', '),
                              Icons.book),
                          _buildProfileInfo('Academic Year',
                              userProfile.academicYear, Icons.calendar_today),
                          _buildProfileInfo(
                              'Attendance',
                              '${userProfile.attendancePercent}%',
                              Icons.check_circle),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(height: 20),

                  // // Edit Profile Button
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       padding: EdgeInsets.symmetric(vertical: 14),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       backgroundColor: Colors.blue[700],
                  //     ),
                  //     child: Text(
                  //       "Edit Profile",
                  //       style: TextStyle(fontSize: 16, color: Colors.white),
                  //     ),
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => EditProfile(),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            );
          }
          return Center(
              child: Text('No data found',
                  style: TextStyle(fontSize: 16, color: Colors.black54)));
        },
      ),
    );
  }

  // Profile Info UI
  Widget _buildProfileInfo(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: AppConstants.mainColor),  // Blue icons
          SizedBox(width: 12),
          Expanded(
            child: Text(
              '$title: $value',
              softWrap: true,
              maxLines: null,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
