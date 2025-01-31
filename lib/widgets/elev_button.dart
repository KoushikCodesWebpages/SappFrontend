import 'package:flutter/material.dart';

class ElevButton extends StatefulWidget {
  final String name;
  final Widget className;

  const ElevButton({
    super.key, 
    required this.name,
    required this.className
  });

  @override
  ElevButtonState createState() => ElevButtonState();
}
  
class ElevButtonState extends State<ElevButton>{
  
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      child: Text(widget.name),
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget.className,
          ),
        );
      },
    );
  }
}