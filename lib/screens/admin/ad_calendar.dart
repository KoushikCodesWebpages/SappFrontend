import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class AdminCalendar extends StatefulWidget {
  @override
  _AdminCalendarState createState() => _AdminCalendarState();
}

class _AdminCalendarState extends State<AdminCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Updated events list with five school events
  Map<DateTime, List<Map<String, dynamic>>> _events = {};

  @override
  void initState() {
    super.initState();
    _loadSampleEvents();
  }

  void _loadSampleEvents() {
    _events = {
      DateTime.utc(2025, 1, 29): [
        {
          'id': '1',
          'title': 'Annual Science Fair',
          'description': 'Students showcase their science projects.',
          'event_type': 'event',
          'event_date': '2025-01-29',
          'created_by': 'Principal',
          'created_at': '2025-01-10 10:00:00',
          'updated_at': '2025-01-12 12:00:00',
        },
      ],
      DateTime.utc(2025, 2, 15): [
        {
          'id': '2',
          'title': 'Math Exam',
          'description': 'Grade 10 Mid-Term Math Exam.',
          'event_type': 'exam',
          'event_date': '2025-02-15',
          'created_by': 'Math Teacher',
          'created_at': '2025-01-12 09:00:00',
          'updated_at': '2025-01-13 11:00:00',
        },
      ],
      DateTime.utc(2025, 2, 25): [
        {
          'id': '3',
          'title': 'Parent-Teacher Meeting',
          'description': 'Meeting to discuss student performance.',
          'event_type': 'meeting',
          'event_date': '2025-02-25',
          'created_by': 'Admin',
          'created_at': '2025-01-14 14:00:00',
          'updated_at': '2025-01-15 16:00:00',
        },
      ],
      DateTime.utc(2025, 3, 10): [
        {
          'id': '4',
          'title': 'Sports Day',
          'description': 'Annual sports event with various competitions.',
          'event_type': 'event',
          'event_date': '2025-03-10',
          'created_by': 'Sports Committee',
          'created_at': '2025-01-16 13:00:00',
          'updated_at': '2025-01-17 15:00:00',
        },
      ],
      DateTime.utc(2025, 3, 20): [
        {
          'id': '5',
          'title': 'Fee Payment Deadline',
          'description': 'Last date for submitting fees for present term.',
          'event_type': 'fee_due',
          'event_date': '2025-03-20',
          'created_by': 'Finance Office',
          'created_at': '2025-01-18 11:00:00',
          'updated_at': '2025-01-19 14:00:00',
        },
      ],
    };
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDay ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDay) {
      setState(() {
        _selectedDay = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventsForSelectedDay =
        _selectedDay != null ? _getEventsForDay(_selectedDay!) : [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Calendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    _selectedDay == null
                        ? 'Select Date'
                        : DateFormat('yyyy-MM-dd').format(_selectedDay!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: TextStyle(color: Colors.red),
              ),
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              onDaySelected: _onDaySelected,
            ),
            const SizedBox(height: 20),
            Text(
              _selectedDay != null
                  ? 'Events for ${DateFormat('yyyy-MM-dd').format(_selectedDay!)}'
                  : 'Select a date to see events',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: eventsForSelectedDay.isEmpty
                  ? Center(
                      child: Text(
                        'No events for this date.',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    )
                  : ListView.builder(
                      itemCount: eventsForSelectedDay.length,
                      itemBuilder: (context, index) {
                        final event = eventsForSelectedDay[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(event['title'] ?? 'No Title'),
                            subtitle: Text(event['description'] ?? 'No Description'),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  event['event_type']?.toUpperCase() ?? '',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Created by: ${event['created_by'] ?? 'Unknown'}',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(event['title'] ?? 'Event Details'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Description: ${event['description']}'),
                                      const SizedBox(height: 8),
                                      Text('Event Type: ${event['event_type']}'),
                                      Text('Date: ${event['event_date']}'),
                                      Text('Created by: ${event['created_by']}'),
                                      Text('Created at: ${event['created_at']}'),
                                      Text('Updated at: ${event['updated_at']}'),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Close'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
