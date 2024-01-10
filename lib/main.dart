import 'package:flutter/material.dart';
import 'package:travel_routes/map_screen.dart';
import 'package:travel_routes/user_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const MapScreen(),
    const UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryColor: const Color.fromARGB(255, 97, 97, 97),
      ),
      routes: {
        '/map' : (context) => const MapScreen(),
        '/user': (context) => const UserScreen(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Find-A-Potty'),
        ),
        body: _screens[_currentIndex],
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
