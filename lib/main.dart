import 'package:flutter/material.dart';

class NavBarExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Navigation Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            color: Colors.blue[400],
            height: 80.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left Section: App Logo and Name
                Row(
                  children: [
                    Icon(Icons.school, color: Colors.white, size: 28.0),
                    SizedBox(width: 8.0),
                    Text(
                      "School Camp",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Center Section: Search Bar
                Flexible(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 3.0),
                    width: 500.0, // Adjusted the width to make it smaller
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Search Class, Documents, Activities...",
                        prefixIcon: Icon(Icons.search,
                            color: Colors.grey), // Search icon
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
                // Right Section: Notifications, Mail, and Profile
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.mail, color: Colors.white),
                      onPressed: () {},
                    ),
                    SizedBox(width: 8.0),
                    CircleAvatar(
                      radius: 18.0,
                      backgroundImage: NetworkImage(
                          'https://idsb.tmgrup.com.tr/ly/uploads/images/2023/11/14/301015.jpg'), // Replace with a user image
                    ),
                    SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Ajay Shanmugam",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Student ID: 05",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Placeholder for Body Content
          Expanded(
            child: Center(
              child: Text(""),
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavBarExample(),
    ));
