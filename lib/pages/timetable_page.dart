import 'package:flutter/material.dart';

class TimetablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timetable'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          border: TableBorder.all(color: Colors.grey),
          children: [
            _buildHeaderRow(), // Header row
            _buildTableRow('Monday',
                ['Math', 'Science', 'English', 'Lunch Break', 'History', 'PE']),
            _buildTableRow('Tuesday', [
              'Physics',
              'Chemistry',
              'Biology',
              'Lunch Break',
              'Math',
              'Art'
            ]),
            _buildTableRow('Wednesday', [
              'Geography',
              'English',
              'Science',
              'Lunch Break',
              'History',
              'Music'
            ]),
            _buildTableRow('Thursday', [
              'Math',
              'Biology',
              'Physics',
              'Lunch Break',
              'PE',
              'Chemistry'
            ]),
            _buildTableRow('Friday', [
              'Art',
              'Math',
              'Science',
              'Lunch Break',
              'English',
              'History'
            ]),
          ],
        ),
      ),
    );
  }

  // Header row for the table
  TableRow _buildHeaderRow() {
    return TableRow(
      children: [
        _buildCell('Day', isHeader: true),
        _buildCell('9:00 - 10:00', isHeader: true),
        _buildCell('10:00 - 11:00', isHeader: true),
        _buildCell('11:00 - 12:00', isHeader: true),
        _buildCell('12:00 - 1:00', isHeader: true),
        _buildCell('1:00 - 2:00', isHeader: true),
        _buildCell('2:00 - 3:00', isHeader: true),
      ],
    );
  }

  // Creates a single table row
  TableRow _buildTableRow(String day, List<String> subjects) {
    return TableRow(
      children: [
        _buildCell(day, isHeader: true),
        for (var subject in subjects) _buildCell(subject),
      ],
    );
  }

  // Creates a single table cell
  Widget _buildCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 16 : 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
