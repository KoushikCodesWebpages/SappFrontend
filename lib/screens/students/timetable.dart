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



//horizontal view, perfect
// import 'package:eg/config/mapp_config.dart';
// import 'package:eg/models/students/timetable_model.dart';
// import 'package:eg/screens/students/portions.dart';
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

//   final List<String> timeSlots = [
//     "Period 1", "Period 2", "Period 3", "Period 4", "Period 5",
//     "Period 6", "Period 7", "Period 8", "Period 9", "Period 10", "Period 11"
//   ]; // 11 periods

//   @override
//   void initState() {
//     super.initState();
//     fetchTimetable();
//   }

//   Future<void> fetchTimetable() async {
//     Timetable? fetchedTimetable =
//         await TimetableService.fetchTimetable(widget.accessToken);
//     setState(() {
//       timetable = fetchedTimetable;
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Student Time Table", style: TextStyle(color: Colors.white),),
//         backgroundColor: AppConstants.mainColor,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : timetable == null
//               ? const Center(child: Text("Timetable not posted yet"))
//               : SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Card(
//                         margin: const EdgeInsets.all(10),
//                         child: Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Academic Year: ${timetable!.academicYear}",
//                                   style: const TextStyle(fontWeight: FontWeight.bold)),
//                               Text("Standard: ${timetable!.standard}"),
//                               Text("Section: ${timetable!.section}"),
//                               Text("Faculty: ${timetable!.facultyName}"),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal, // Allow horizontal scrolling
//                         child: DataTable(
//                           border: TableBorder.all(color: Colors.black),
//                           columns: _generateColumns(),
//                           rows: _generateRows(),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       const Text(
//                         "Portions",
//                         style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
//                       ),
//                       SizedBox(
//                         height: 400, // Adjust the height to fit within scrollable view
//                         child: StuPortionScreen(accessToken: AppConfig.accessToken),
//                       ),
//                     ],
//                   ),
//                 ),
//     );
//   }

//   // Generate column headers: "Day" + 11 time slots
//   List<DataColumn> _generateColumns() {
//     return [
//       const DataColumn(
//           label: Text("Day", style: TextStyle(fontWeight: FontWeight.bold))),
//       ...timeSlots.map((slot) => DataColumn(
//           label: Text(slot, style: const TextStyle(fontWeight: FontWeight.bold))))
//     ];
//   }

//   // Generate rows with each day's subjects aligned under the correct period
//   List<DataRow> _generateRows() {
//     List<DataRow> rows = [];

//     for (String day in ["monday", "tuesday", "wednesday", "thursday", "friday"]) {
//       if (timetable!.schedule[day] != null) {
//         List<String> subjects = timetable!.schedule[day]!;

//         // Create row for the day
//         rows.add(DataRow(cells: [
//           DataCell(Text(day.toUpperCase().substring(0,3), style: const TextStyle(fontWeight: FontWeight.bold))),
//           ...List.generate(11, (index) => DataCell(
//               index < subjects.length ? Text(subjects[index]) : const Text("")))
//         ]));
//       }
//     }

//     return rows;
//   }
// }


import 'package:eg/config/mapp_config.dart';
import 'package:eg/models/students/timetable_model.dart';
import 'package:eg/screens/students/portions.dart';
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

  final List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
  final List<String> timeSlots = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"];

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
      backgroundColor: Colors.white, 
      appBar: AppBar(
        title: const Text("Timetable", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppConstants.mainColor,
        elevation: 2,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : timetable == null
              ? const Center(
                  child: Text(
                    "Timetable not posted yet",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _infoText("Academic Year", timetable!.academicYear),
                                _infoText("Standard", timetable!.standard),
                                _infoText("Section", timetable!.section),
                                _infoText("Faculty", timetable!.facultyName),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: DataTable(
                                border: TableBorder.all(color: Colors.black26, width: 1),
                                columnSpacing: 12,
                                dataRowMinHeight: 35,
                                dataRowMaxHeight: 40,
                                headingRowHeight: 40,
                                horizontalMargin: 10,
                                headingRowColor: MaterialStateColor.resolveWith((_) => AppConstants.mainColor),
                                columns: _generateColumns(),
                                rows: _generateRows(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Portions",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 400,
                          child: StuPortionScreen(accessToken: AppConfig.accessToken),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _infoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        "$label: $value",
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  List<DataColumn> _generateColumns() {
    return [
      const DataColumn(label: Text("Period", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
      ...days.map((day) => DataColumn(
          label: Text(day, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
    ];
  }

  List<DataRow> _generateRows() {
    return List.generate(timeSlots.length, (i) {
      return DataRow(cells: [
        DataCell(Text(timeSlots[i], style: const TextStyle(fontWeight: FontWeight.bold))),
        ...days.map((day) {
          List<String>? subjects = timetable!.schedule[day.toLowerCase()];
          return DataCell(Text(subjects != null && i < subjects.length ? subjects[i] : "", textAlign: TextAlign.center));
        }).toList(),
      ]);
    });
  }
}
