import 'package:flutter/material.dart';
import 'package:travel_routes/screens/map_screen.dart';
import 'package:travel_routes/screens/user_screen.dart';
import 'package:travel_routes/screens/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryColor: const Color.fromARGB(255, 97, 97, 97),
      ),
      routes: {
        '/map': (context) => const MapScreen(),
        '/user': (context) => const UserScreen(),
        '/start': (context) => const StartScreen(),
      },
      initialRoute: '/start',
    );
  }
}