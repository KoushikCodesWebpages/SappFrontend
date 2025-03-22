import 'package:eg/widgets/faculty/dashboard_details.dart';
import 'package:flutter/material.dart';

class AppConstants {

  static const String appName = "Sapp";
  static const Color mainColor = Color(0xff8399f9);

  //Students
  static TextEditingController mailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static String roleController = "student";

  //Profile data
  static String name = '';
  static String standard = '';
  static String section = '';
  static String academicYear = '';
  
}