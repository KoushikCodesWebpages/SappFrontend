import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Admin Calendar',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         textTheme: TextTheme(
//           bodyMedium: TextStyle(color: Colors.black87), // Use bodyMedium instead of bodyText2
//         ),
//       ),
//       home: AdminCalendar(),
//     );
//   }
// }

class AdminCalendar extends StatefulWidget {
  const AdminCalendar({super.key});
  @override
  AdminCalendarState createState() => AdminCalendarState();
}

class AdminCalendarState extends State<AdminCalendar> {
  late DateTime _selectedDay;
  late List _selectedEvents;
  late Map<DateTime, List> _events;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _events = {};
    _selectedEvents = [];
    _fetchEvents(_selectedDay);  // Fetch events for the initial selected day
  }

  void _fetchEvents(DateTime day) async {
    //final date = "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
    final response = await http.get(Uri.parse('http://127.0.0.1:5014/calender'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _events = {}; // Clear old events
        _selectedEvents = [];
        // Populate events based on the date
        for (var event in data['calendar']) {
          DateTime eventDate = DateTime.parse(event['date']);
          if (eventDate.year == day.year && eventDate.month == day.month && eventDate.day == day.day) {
            _events[day] = _events[day] ?? [];
            _events[day]?.add(event);
          }
        }
        _selectedEvents = _events[day] ?? [];
      });
    } else {
      print('Failed to load events');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Calendar'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // TableCalendar Widget
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TableCalendar(
              firstDay: DateTime.utc(2025, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _selectedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _fetchEvents(selectedDay); // Fetch events when a day is selected
                });
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: Icon(Icons.chevron_left, color: Colors.blue),
                rightChevronIcon: Icon(Icons.chevron_right, color: Colors.blue),
              ),
            ),
          ),
          
          // Display the events for the selected date
          Expanded(
            child: _selectedEvents.isEmpty
                ? Center(child: Text('No events for this day'))
                : ListView.builder(
                    itemCount: _selectedEvents.length,
                    itemBuilder: (context, index) {
                      final event = _selectedEvents[index];
                      return EventCard(event: event);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final dynamic event;

  const EventCard({super.key,required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.event, color: Colors.blue),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['event_title'],
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Date: ${event['date']}',
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
