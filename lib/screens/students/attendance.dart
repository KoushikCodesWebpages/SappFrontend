import 'package:eg/utils/constants.dart';
import 'package:flutter/material.dart';
import '../../models/students/attendance_model.dart';
import '../../services/students/attendance_service.dart';

class StuAttendance extends StatefulWidget {
  const StuAttendance({super.key});

  @override
  StuAttendanceState createState() => StuAttendanceState();
}

class StuAttendanceState extends State<StuAttendance> {
  final AttendanceService _attendanceService = AttendanceService();
  List<Attendance> attendance = [];
  List<Attendance> filteredAttendance = [];
  bool isLoading = true;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchAttendance();
  }

  Future<void> fetchAttendance() async {
    try {
      List<Attendance> data = await _attendanceService.fetchAttendance();
      setState(() {
        attendance = data;
        filteredAttendance = filterAttendanceByMonthYear(selectedDate);
        isLoading = false;
      });
    } catch (error) {
      setState(() => isLoading = false);
      debugPrint('Error fetching attendance: $error');
    }
  }

  List<Attendance> filterAttendanceByMonthYear(DateTime date) {
    return attendance.where((data) {
      return data.date.year == date.year && data.date.month == date.month;
    }).toList();
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppConstants.mainColor,
            colorScheme: ColorScheme.light(
              primary: AppConstants.mainColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
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
        title: const Text('Attendance', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: AppConstants.mainColor,
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
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green, size: 20),
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
                    ? const Expanded(child: Center(child: CircularProgressIndicator()))
                    : (filteredAttendance.isEmpty
                        ? const Expanded(child: Center(child: Text('No attendance data available')))
                        : Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  columns: [
                                    DataColumn(
                                      label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
                                    ),
                                    DataColumn(
                                      label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                  rows: filteredAttendance.map((data) {
                                    final isPresent = data.status.toLowerCase() == 'present';
                                    return DataRow(cells: [
                                      DataCell(Text(data.date.toIso8601String().split('T')[0])),
                                      DataCell(
                                        Icon(
                                          isPresent ? Icons.check_circle : Icons.cancel,
                                          color: isPresent ? Colors.green : Colors.red,
                                          size: 24,
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
                backgroundColor: AppConstants.mainColor,
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
