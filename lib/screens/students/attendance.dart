import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StuAttendance extends StatefulWidget {
  const StuAttendance({super.key});

  @override
  StuAttendanceState createState() => StuAttendanceState(); // Ensure this is used only internally
}

class StuAttendanceState extends State<StuAttendance> {
  List<dynamic> attendance = [];
  List<dynamic> filteredAttendance = [];
  bool isLoading = true;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchAttendance();
  }

  Future<void> fetchAttendance() async {
    try {
      final response =
          await http.get(Uri.parse('http://127.0.0.1:5016/attendance'));
      if (response.statusCode == 200) {
        setState(() {
          attendance = json.decode(response.body)['attendance'];
          filteredAttendance = filterAttendanceByMonthYear(selectedDate);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load attendance');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching attendance: $error'); // Replace `print` with `debugPrint`
    }
  }

  List<dynamic> filterAttendanceByMonthYear(DateTime date) {
    return attendance.where((data) {
      final dataDate = DateTime.parse(data['date']);
      return dataDate.year == date.year && dataDate.month == date.month;
    }).toList();
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromARGB(255, 98, 148, 224), // Blue color
            colorScheme: ColorScheme.light(
              primary: const Color.fromARGB(255, 98, 148, 224), // Blue color
              onPrimary: Colors.white, // Text color on selected date
              onSurface: Colors.black, // Text color on unselected dates
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        filteredAttendance = filterAttendanceByMonthYear(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Attendance'),
        backgroundColor: const Color.fromARGB(255, 98, 148, 224),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0), // Add left padding
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle,
                              color: Colors.green, size: 20),
                          const SizedBox(width: 5),
                          const Text('Present'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        const Icon(Icons.cancel, color: Colors.red, size: 20),
                        const SizedBox(width: 5),
                        const Text('Absent'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                isLoading
                    ? const Expanded(
                        child: Center(child: CircularProgressIndicator()))
                    : (filteredAttendance.isEmpty
                        ? const Expanded(
                            child: Center(
                                child: Text('No attendance data available')))
                        : Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  columns: [
                                    DataColumn(
                                        label: Text(
                                      'Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Status',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ],
                                  rows: filteredAttendance.map((data) {
                                    final isPresent = data['status']
                                            .toLowerCase() ==
                                        'present';
                                    return DataRow(cells: [
                                      DataCell(
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(data['date']),
                                        ),
                                      ),
                                      DataCell(
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Icon(
                                            isPresent
                                                ? Icons.check_circle
                                                : Icons.cancel,
                                            color: isPresent
                                                ? Colors.green
                                                : Colors.red,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ]);
                                  }).toList(),
                                ),
                              ),
                            ),
                          )),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: () => pickDate(context),
                backgroundColor: const Color.fromARGB(255, 98, 148, 224),
                tooltip: 'Pick Month and Year',
                child: const Icon(Icons.calendar_today),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
