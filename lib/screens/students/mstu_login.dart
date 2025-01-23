import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../widgets/mtext_display.dart';
import '../../widgets/mtext_field.dart';
import '../../services/students/mstu_login_service.dart';
import '../../screens/profile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final StuLoginService _authService = StuLoginService();

  void _login() async {
    try {
      String token = await _authService.login(
        AppConstants.mailController.text,
        AppConstants.passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),//(token: token),
        ),
      );
    } catch (e) {
      // Handle login error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }
  //---------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.mainColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school, color: Colors.white),
                  SizedBox(width: 10),
                  TextDisplay(text: AppConstants.appName,color: Colors.white, fontSize: 28),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 400,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const[
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TextDisplay(text: 'Login Form'),
                      const SizedBox(height: 16),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: TextDisplay(text: 'E-mail', fontSize: 17,),
                      ),
                      const SizedBox(height: 5),
                      TextInputBox(control: AppConstants.mailController, label: 'Enter your E-mail', preIcon: Icons.email,),
                      const SizedBox(height: 16),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: TextDisplay(text: 'Password', fontSize: 17,),
                      ),
                      const SizedBox(height: 5),
                      TextInputBox(control: AppConstants.passwordController, label: 'Enter your Password', preIcon: Icons.lock,sufIcon: Icons.visibility,),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignupScreen()), 
                            );*/ //Add forgot password page
                          },
                          child: const TextDisplay(text:'Forgot password?', color: Colors.blue, fontSize: 14, fontWeight: FontWeight.normal,)
                        )
                      ),
                      //const ElevButton(text: 'Login'),
                      ElevatedButton(
                        onPressed: _login,
                        child: Text('Login'),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
