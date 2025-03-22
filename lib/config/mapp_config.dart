import 'package:eg/utils/constants.dart';

class AppConfig {
   static const String baseUrl = 'http://127.0.0.1:8000';
   static const String loginUrl = '$baseUrl/login/';

   //Students 
   static const String stuProfileUrl = '$baseUrl/student/profile/';
   static const String stuAnnouncementsUrl = '$baseUrl/office/announcement/';
   static const String stuCalendarUrl = '$baseUrl/office/calendar/';
   static String stuTimetable = '$baseUrl/office/timetables/?standard=${AppConstants.standard}&section=${AppConstants.section}';//change this
   static const String stuAssignmentsUrl = '$baseUrl/faculty/assignments/'; //?standard=7&section=C';//change this
   static const String stuResultsUrl = '$baseUrl/student/results/';
   static String stuPortionsUrl = '$baseUrl/portions/?standard=${AppConstants.standard}&academic_year=${AppConstants.academicYear}';
   static const String stuSubmissionUrl = '$baseUrl/student/submissions/';
   static String stuAttendanceUrl = '$baseUrl/class/attendance/?email=${AppConstants.mailController.text}';

   //Faculty
   static const String facProfileUrl= '$baseUrl/faculty/profile/';
   static const String facAssignmentsUrl = '$baseUrl/faculty/assignments/';
   static String stuListUrl = "$baseUrl/faculty/filter-students/?class=['${AppConstants.standard}', '${AppConstants.section}', '${AppConstants.academicYear}']"; //faculty/filter-students/?class=['9', 'C', '2024-2025']
   static const String facResultsLockUrl = '$baseUrl/office/resultlock/';
   static const String facResultsPostUrl = '$baseUrl/faculty/results/';
   static const String facPortionsUrl = '$baseUrl/portions/';

   static String accessToken = "";
   static String refreshToken = "";
}