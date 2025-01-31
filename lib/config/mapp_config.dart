class AppConfig {
   static const String _baseUrl = 'http://127.0.0.1:8000'; 
   static const String loginUrl = '$_baseUrl/login/'; 
   static const String profileUrl = '$_baseUrl/student-profile/<str:student_code>/';
   static const String stuAnnouncementsUrl = '$_baseUrl/office/announcementdisplay/';

   static String accessToken = "";
   static String refreshToken = "";
}