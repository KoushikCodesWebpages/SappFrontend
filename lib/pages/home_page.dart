import 'package:flutter/material.dart';
import '../widgets/timetable_card.dart';
import 'timetable_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('School App'),
      ),
      body: Center(
        child: TimetableCard(
          imagePath: 'assets/timetable_image.png',
          title: 'Timetable',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TimetablePage()),
            );
          },
        ),
      ),
    );
  }
}
