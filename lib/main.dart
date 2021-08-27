import 'package:flutter/material.dart';
import 'package:flutter_app_food/page/sign_in/sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      initialRoute: "/sign-in",
      routes: {
        "/sign-in" : (context) => SignInPage()
      },
    );
  }
}
