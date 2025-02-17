//with dropdown
// import 'package:eg/models/students/timetable_model.dart';
// import 'package:eg/services/students/timetable_service.dart';
// import 'package:eg/utils/constants.dart';
// import 'package:flutter/material.dart';

// class StuTimetableScreen extends StatefulWidget {
//   final String accessToken;

//   const StuTimetableScreen({super.key, required this.accessToken});

//   @override
//   StuTimetableScreenState createState() => StuTimetableScreenState();
// }

// class StuTimetableScreenState extends State<StuTimetableScreen> {
//   Timetable? timetable;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchTimetable();
//   }

//   Future<void> fetchTimetable() async {
//     Timetable? fetchedTimetable = await TimetableService.fetchTimetable(widget.accessToken);
//     setState(() {
//       timetable = fetchedTimetable;
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Student Time Table"), backgroundColor: AppConstants.mainColor),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : timetable == null
//               ? const Center(child: Text("Failed to load timetable"))
//               : Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Display Metadata
                      // Card(
                      //   margin: const EdgeInsets.all(10),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(10),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text("Academic Year: ${timetable!.academicYear}",
                      //             style: const TextStyle(fontWeight: FontWeight.bold)),
                      //         Text("Standard: ${timetable!.standard}"),
                      //         Text("Section: ${timetable!.section}"),
                      //         Text("Faculty: ${timetable!.facultyName}"),
                      //       ],
                      //     ),
                      //   ),
                      // ),

//                       // Timetable Display
//                       Expanded(
//                         child: ListView(
//                           children: [
//                             for (String day in ["monday", "tuesday", "wednesday", "thursday", "friday"])
//                               if (timetable!.schedule[day] != null)
//                                 Card(
//                                   margin: const EdgeInsets.all(10),
//                                   child: ExpansionTile(
//                                     title: Text(day.toUpperCase(),
//                                         style: const TextStyle(fontWeight: FontWeight.bold)),
//                                     children: [
//                                       for (String subject in timetable!.schedule[day]!)
//                                         ListTile(title: Text(subject)),
//                                     ],
//                                   ),
//                                 ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//     );
//   }
// }




import 'package:eg/models/students/timetable_model.dart';
import 'package:eg/services/students/timetable_service.dart';
import 'package:eg/utils/constants.dart';
import 'package:flutter/material.dart';

class StuTimetableScreen extends StatefulWidget {
  final String accessToken;

  const StuTimetableScreen({super.key, required this.accessToken});

  @override
  StuTimetableScreenState createState() => StuTimetableScreenState();
}

class StuTimetableScreenState extends State<StuTimetableScreen> {
  Timetable? timetable;
  bool isLoading = true;

  final List<String> timeSlots = [
    "Period 1", "Period 2", "Period 3", "Period 4", "Period 5",
    "Period 6", "Period 7", "Period 8", "Period 9", "Period 10", "Period 11"
  ]; // 11 periods

  @override
  void initState() {
    super.initState();
    fetchTimetable();
  }

  Future<void> fetchTimetable() async {
    Timetable? fetchedTimetable =
        await TimetableService.fetchTimetable(widget.accessToken);
    setState(() {
      timetable = fetchedTimetable;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Student Time Table"),
          backgroundColor: AppConstants.mainColor),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : timetable == null
              ? const Center(child: Text("Failed to load timetable"))
              : Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Academic Year: ${timetable!.academicYear}",
                                  style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text("Standard: ${timetable!.standard}"),
                              Text("Section: ${timetable!.section}"),
                              Text("Faculty: ${timetable!.facultyName}"),
                            ],
                          ),
                        ),
                      ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal, // Allow horizontal scrolling
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical, // Allow vertical scrolling
                      child: DataTable(
                        border: TableBorder.all(color: Colors.black),
                        columns: _generateColumns(),
                        rows: _generateRows(),
                      ),
                    ),
                  ),
                  ]
                  )
                ),
    );
  }

  // Generate column headers: "Day" + 11 time slots
  List<DataColumn> _generateColumns() {
    return [
      const DataColumn(
          label: Text("Day", style: TextStyle(fontWeight: FontWeight.bold))),
      ...timeSlots.map((slot) => DataColumn(
          label: Text(slot, style: const TextStyle(fontWeight: FontWeight.bold))))
    ];
  }

  // Generate rows with each day's subjects aligned under the correct period
  List<DataRow> _generateRows() {
    List<DataRow> rows = [];

    for (String day in ["monday", "tuesday", "wednesday", "thursday", "friday"]) {
      if (timetable!.schedule[day] != null) {
        List<String> subjects = timetable!.schedule[day]!;

        // Create row for the day
        rows.add(DataRow(cells: [
          DataCell(Text(day.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold))),
          ...List.generate(11, (index) => DataCell(
              index < subjects.length ? Text(subjects[index]) : const Text("")))
        ]));
      }
    }

    return rows;
  }
}
