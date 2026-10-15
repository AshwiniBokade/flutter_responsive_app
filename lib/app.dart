
import 'package:flutter/material.dart';
import 'package:flutter_responsive_app/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
   Widget build(BuildContext context) {
    return MaterialApp(title: 'Responsive App', debugShowCheckedModeBanner: false, home: HomeScreen(),);
    }
  }