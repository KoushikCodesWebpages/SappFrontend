import 'package:eg/utils/constants.dart';
import 'package:flutter/material.dart';

class AnnouncementWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppConstants.mainColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Announcement',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text('31st August | 10:30pm', style: TextStyle(color: Colors.white)),
                Spacer(),
                TextButton(onPressed: () {}, child: Text('See previous')),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.campaign, color: Colors.red),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Parents Teachers Meeting',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
