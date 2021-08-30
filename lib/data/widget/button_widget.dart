import 'package:flutter/material.dart';
class ButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPress;

  ButtonWidget({required this.title, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonTheme(
        data: ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.blue[500];
            } else if (states.contains(MaterialState.disabled)){
              return Colors.grey;
            }
            return Colors.blueAccent;
          }),
          elevation: MaterialStateProperty.all(5),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: 5, horizontal: 100)),
        )),
        child: ElevatedButton(
          child:
              Text(title, style: TextStyle(fontSize: 18, color: Colors.white)),
          onPressed: onPress,
        ));
  }
}
