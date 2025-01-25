import 'package:flutter/material.dart';

class AdProfile extends StatelessWidget {
  const AdProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4A90E2),
          title: const Text(
            "Admin Profile",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // To go back to the previous screen
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Profile Picture and User Information
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Admin User",
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                const Text(
                  "admin@example.com", // Placeholder email, you can update it with dynamic data
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                // Smaller User Details Section with Fixed Width
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  color: Color.fromARGB(255, 162, 159, 218), // Attractive color
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Reduced padding
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 300), // Fixed width for the box
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "User Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 12), // Reduced space
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Full Name:",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white70), // Smaller text size
                              ),
                              Text(
                                "Admin User",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white), // Smaller text size
                              ),
                            ],
                          ),
                          const SizedBox(height: 12), // Reduced space
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Phone Number:",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white70), // Smaller text size
                              ),
                              Text(
                                "+1 234 567 890",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white), // Smaller text size
                              ),
                            ],
                          ),
                          const SizedBox(height: 12), // Reduced space
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Location:",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white70), // Smaller text size
                              ),
                              Text(
                                "New York, USA",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white), // Smaller text size
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Edit Profile Button
                ElevatedButton(
                  onPressed: () {
                    // Add your edit profile functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A90E2), // Matching button color
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
