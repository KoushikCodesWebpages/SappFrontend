import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(CalendarApp());
}

class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Calendar Example")),
        body: Center(
          child: CalendarWidget(),
        ),
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _selectedDate = DateTime(2025, 1, 1); // Start from Jan 2025
  final DateTime _today = DateTime.now();

  // Function to calculate the number of days in a given month
  int daysInMonth(DateTime date) {
    var beginningNextMonth = (date.month < 12)
        ? DateTime(date.year, date.month + 1, 1)
        : DateTime(date.year + 1, 1, 1);
    return beginningNextMonth.subtract(Duration(days: 1)).day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Reduce the size to match the design
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Blue bar at the top
          Container(
            height: 8, // Thin blue bar
            width: double.infinity,
            color: Colors.blue, // Blue color for the bar
          ),

          const SizedBox(height: 8), // Space between the bar and the header

          // Month Navigation Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedDate = DateTime(
                        _selectedDate.year, _selectedDate.month - 1, 1);
                  });
                },
                icon: Icon(Icons.chevron_left),
              ),
              Text(
                DateFormat.yMMMM().format(_selectedDate),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedDate = DateTime(
                        _selectedDate.year, _selectedDate.month + 1, 1);
                  });
                },
                icon: Icon(Icons.chevron_right),
              ),
            ],
          ),

          const SizedBox(height: 8), // Spacing between rows

          // Days of the week row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Sun", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Mon", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Tue", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Wed", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Thu", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Fri", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Sat", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),

          const SizedBox(height: 8), // Spacing between rows

          // Grid of dates
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: daysInMonth(_selectedDate),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, // 7 days in a week
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemBuilder: (context, index) {
              final currentDay = DateTime(
                _selectedDate.year,
                _selectedDate.month,
                index + 1,
              );
              final isToday = _today.year == currentDay.year &&
                  _today.month == currentDay.month &&
                  _today.day == currentDay.day;
              final isSelected = _selectedDate.year == currentDay.year &&
                  _selectedDate.month == currentDay.month &&
                  _selectedDate.day == currentDay.day;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = currentDay;
                  });

                  // Show dialog on tap
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                            "Event on ${DateFormat('yyyy-MM-dd').format(currentDay)}"),
                        content: Text("This is an event!"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Close"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isToday
                        ? Colors.yellow.shade200
                        : (isSelected ? Colors.blue.shade100 : null),
                    border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Text(
                      currentDay.day.toString(),
                      style: TextStyle(
                        color: isToday
                            ? Colors.orange
                            : (isSelected ? Colors.blue : Colors.black),
                        fontWeight: isSelected || isToday
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
