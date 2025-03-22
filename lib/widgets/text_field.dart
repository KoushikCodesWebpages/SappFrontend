import 'package:flutter/material.dart';
import '../utils/constants.dart';

class TextInputBox extends StatefulWidget {
  final String label;
  final TextEditingController? control;
  final Color iconColor;
  final IconData? sufIcon;
  final IconData? preIcon;
  final bool labelActivity;
  final double radius;

  const TextInputBox({
    super.key,
    required this.control,
    this.label = '',
    this.iconColor = AppConstants.mainColor,
    this.sufIcon,
    this.preIcon,
    this.labelActivity = true,
    this.radius = 11.0,
  });

  @override
  TextInputBoxState createState() => TextInputBoxState();
}

class TextInputBoxState extends State<TextInputBox> {
  bool isPasswordVisible = false; 

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.control,
      obscureText: widget.sufIcon != null && !isPasswordVisible, 
      decoration: InputDecoration(
        floatingLabelBehavior: widget.labelActivity==false? FloatingLabelBehavior.never: FloatingLabelBehavior.auto,
        labelText: widget.label,
        prefixIcon: widget.preIcon != null
            ? Icon(
                widget.preIcon,
                color: widget.iconColor,
              )
            : null,
        suffixIcon: widget.sufIcon != null
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                child: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: widget.iconColor,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
        ),
      ),
    );
  }
}
