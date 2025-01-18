import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StuTimetable extends StatefulWidget {
  const StuTimetable({super.key});

  @override
  _StuTimetableState createState() => _StuTimetableState();
}

class _StuTimetableState extends State<StuTimetable> {
  Map<String, dynamic>? timetable;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTimetable();
  }

  Future<void> fetchTimetable() async {
    const String apiUrl =
        "http://127.0.0.1:5008/timetable"; // Update this to match your API URL if needed
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          timetable = json.decode(response.body)['timetable'];
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load timetable");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching timetable: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Student Time Table"),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : timetable == null
                ? const Center(child: Text("Failed to load timetable"))
                : ListView.builder(
                    itemCount: timetable!.keys.length,
                    itemBuilder: (context, index) {
                      String day = timetable!.keys.elementAt(index);
                      List<String> subjects =
                          List<String>.from(timetable![day]);
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ExpansionTile(
                          title: Text(day),
                          children: subjects
                              .map((subject) => ListTile(
                                    title: Text(subject),
                                  ))
                              .toList(),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
