import 'package:eg/screens/students/main_screen.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../widgets/text_display.dart';
import '../../widgets/text_field.dart';
import '../../services/students/login_service.dart';
import '../../models/students/login_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final AuthService authService = AuthService();
  bool isLoading = false;

  void login() async {
    FocusScope.of(context).unfocus();
    setState(() => isLoading = true);

    LoginRequest request = LoginRequest(
      email: AppConstants.mailController.text,
      password: AppConstants.passwordController.text,
      role: AppConstants.roleController ,
    );

    LoginResponse? response = await authService.login(request);
    
    setState(() => isLoading = false);

    if (response != null) {
      FocusScope.of(context).unfocus();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
        );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Successful: ${response.accessToken}")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Failed")),
      );
    }
  }

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
                height: 500,
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
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: TextDisplay(text: 'Role', fontSize: 17,),
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Focus(
  onFocusChange: (hasFocus) {
    if (!hasFocus) {
      FocusScope.of(context).unfocus();
    }
  },
  child:
                        DropdownButton<String>(
                          alignment: Alignment.centerLeft,
                          focusColor: AppConstants.mainColor,
                          elevation: 18,
                          underline:Container(
                            height: 2,
                            color: AppConstants.mainColor,
                          ),
                          value: AppConstants.roleController,
                          hint: Text("Select Role"),
                          onChanged: (String? newValue) {
                            setState(() => AppConstants.roleController = newValue ?? "student");
                          },
                          items: ["student", "teacher", "admin"].map((role) => DropdownMenuItem(value: role, child: Text(role))).toList(),
                        ),
                        )
                        ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: login,
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(AppConstants.mainColor),
                          elevation: WidgetStateProperty.all(5)
                        ),
                        
                        child: Text('Login', style: TextStyle(fontSize: 16, color: const Color.fromARGB(200, 255, 255, 255)),),
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
