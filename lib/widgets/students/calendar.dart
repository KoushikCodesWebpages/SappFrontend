import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/students/calendar_model.dart';
import '../../services/students/calendar_service.dart';

class CalendarScreen extends StatefulWidget {

  const CalendarScreen({super.key});

  @override
  CalendarScreenState createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  late EventService _eventService;
  late Map<DateTime, List<Event>> _events = {};
  DateTime _selectedDay = DateTime.now();
  List<Event> _selectedEvents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _eventService = EventService();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    try {
      List<Event> fetchedEvents = await _eventService.fetchEvents();

      // Convert list to Map<DateTime, List<Event>>
      Map<DateTime, List<Event>> eventMap = {};
      for (var event in fetchedEvents) {
        DateTime date = DateTime(event.eventDate.year, event.eventDate.month, event.eventDate.day);
        eventMap[date] = (eventMap[date] ?? [])..add(event);
      }

      setState(() {
        _events = eventMap;
        _selectedEvents = _events[_selectedDay] ?? [];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading events: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2022, 1, 1),
                    lastDay: DateTime.utc(2025, 12, 31),
                    focusedDay: _selectedDay,
                    calendarFormat: CalendarFormat.month,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    headerStyle: const HeaderStyle(formatButtonVisible: false),
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                      selectedDecoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      weekendTextStyle: const TextStyle(color: Colors.red),
                    ),
                    eventLoader: (day) => _events[DateTime(day.year, day.month, day.day)] ?? [],
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _selectedEvents = _events[DateTime(selectedDay.year, selectedDay.month, selectedDay.day)] ?? [];
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  _selectedEvents.isNotEmpty
                        ? SizedBox(
                          width: double.infinity,
                        height: 500,
                        child: ListView.builder(
                            itemCount: _selectedEvents.length,
                            itemBuilder: (context, index) {
                              final event = _selectedEvents[index];
                              return Card(
                                child: ListTile(
                                  title: Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text(event.description),
                                ),
                              );
                            },
                          )
                        )
                        : const Center(child: Text("No events for this day.")),
                  
                ],
              ),
            ),
    );
  }
}
