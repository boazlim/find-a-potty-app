import 'package:flutter/material.dart';
import 'package:travel_routes/location.dart';
import 'package:travel_routes/map_screen.dart';
import 'package:travel_routes/user_screen.dart';
import 'package:travel_routes/start_screen.dart'; // Import the StartScreen

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MyApp> {
  int _currentIndex = 0;
  late User user; // Add this line to store the user object

  @override
  void initState() {
    super.initState();
    // Create a default user when the app starts
    user = User('DefaultUser');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryColor: const Color.fromARGB(255, 97, 97, 97),
      ),
      routes: {
        '/map': (context) => MapScreen(), // Pass the user to MapScreen
        '/user': (context) => UserScreen(user: user), // Pass the user to UserScreen
      },
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Find-A-Potty'),
        ),
        body: _currentIndex == 0
            ? MapScreen() // Pass the user to MapScreen
            : UserScreen(user: user), // Pass the user to UserScreen
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}
