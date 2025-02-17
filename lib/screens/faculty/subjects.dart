import 'package:flutter/material.dart';

class SubjectsPage extends StatefulWidget {
  const SubjectsPage({super.key});

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  Set<String> expandedClasses = {}; // Stores which classes are expanded

  final Map<String, List<String>> standardTimetable = {
    "Monday": ["Math", "Science", "English", "History", "Geography", "-", "-", "-", "-", "-", "-"],
    "Tuesday": ["Science", "Math", "English", "History", "Geography", "-", "-", "-", "-", "-", "-"],
    "Wednesday": ["English", "Math", "Science", "History", "Geography", "-", "-", "-", "-", "-", "-"],
    "Thursday": ["History", "Math", "Science", "English", "Geography", "-", "-", "-", "-", "-", "-"],
    "Friday": ["Geography", "Math", "Science", "English", "History", "-", "-", "-", "-", "-", "-"],
  };

  final Map<String, Map<String, List<String>>> classTimetables = {
    "9C": {
      "Monday": ["Math", "Science", "English", "History", "Geography", "-", "-", "-", "-", "-", "-"],
      "Tuesday": ["Science", "Math", "English", "History", "Geography", "-", "-", "-", "-", "-", "-"],
      "Wednesday": ["English", "Math", "Science", "History", "Geography", "-", "-", "-", "-", "-", "-"],
      "Thursday": ["History", "Math", "Science", "English", "Geography", "-", "-", "-", "-", "-", "-"],
      "Friday": ["Geography", "Math", "Science", "English", "History", "-", "-", "-", "-", "-", "-"],
    },
    "7B": {
      "Monday": ["English", "Math", "Science", "Social", "Art", "-", "-", "-", "-", "-", "-"],
      "Tuesday": ["Math", "English", "Science", "Social", "Art", "-", "-", "-", "-", "-", "-"],
      "Wednesday": ["Science", "English", "Math", "Social", "Art", "-", "-", "-", "-", "-", "-"],
      "Thursday": ["Social", "English", "Math", "Science", "Art", "-", "-", "-", "-", "-", "-"],
      "Friday": ["Art", "English", "Math", "Science", "Social", "-", "-", "-", "-", "-", "-"],
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Class Timetable")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Standard Timetable", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildTimetableTable(standardTimetable),
              const SizedBox(height: 20),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: classTimetables.keys.length,
                itemBuilder: (context, index) {
                  String className = classTimetables.keys.elementAt(index);
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (expandedClasses.contains(className)) {
                              expandedClasses.remove(className);
                            } else {
                              expandedClasses.add(className);
                            }
                          });
                        },
                        child: Card(
                          color: Colors.blueAccent,
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(className, style: const TextStyle(fontSize: 18, color: Colors.white)),
                                Icon(
                                  expandedClasses.contains(className) ? Icons.expand_less : Icons.expand_more,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (expandedClasses.contains(className)) _buildTimetableTable(classTimetables[className]!),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimetableTable(Map<String, List<String>> timetable) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          border: TableBorder.all(color: Colors.black),
          columns: _generateColumns(),
          rows: _generateRows(timetable),
        ),
      ),
    );
  }

  List<DataColumn> _generateColumns() {
    return [
      const DataColumn(label: Text("Day", style: TextStyle(fontWeight: FontWeight.bold))),
      ...List.generate(11, (index) => DataColumn(label: Text("Period ${index + 1}"))),
    ];
  }

  List<DataRow> _generateRows(Map<String, List<String>> timetable) {
    return timetable.entries.map((entry) {
      return DataRow(cells: [
        DataCell(Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold))),
        ...entry.value.map((subject) => DataCell(Text(subject.isNotEmpty ? subject : "-"))),
      ]);
    }).toList();
  }
}
