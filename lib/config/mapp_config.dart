class AppConfig {
   static const String _baseUrl = 'http://127.0.0.1:8000';
   static const String loginUrl = '$_baseUrl/login/';

   //Students 
   static const String stuProfileUrl = '$_baseUrl/student-profile/<str:student_code>/';
   static const String stuAnnouncementsUrl = '$_baseUrl/office/announcementdisplay/';
   static const String stuCalendarUrl = '$_baseUrl/office/calendar/';
   static const String stuResultsUrl = '$_baseUrl/office/resultlock/';
   static const String stuTimetable = '$_baseUrl/office/timetables/?standard=7&section=C';//change this

   //Faculty
   static const String facProfileUrl= '$_baseUrl/faculty/profile/';

   static String accessToken = "";
   static String refreshToken = "";
}