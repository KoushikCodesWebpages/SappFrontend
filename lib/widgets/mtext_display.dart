import 'package:flutter/material.dart';

class TextDisplay extends StatelessWidget {
  final String text;          
  final double fontSize;      
  final FontWeight fontWeight;
  final Color color; 

  const TextDisplay({
    super.key,
    required this.text,
    this.fontSize = 24,         
    this.fontWeight = FontWeight.bold,
    this.color = Colors.black, 
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
