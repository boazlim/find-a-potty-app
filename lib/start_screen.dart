import 'package:flutter/material.dart';
import 'package:travel_routes/location.dart';
import 'package:travel_routes/user_screen.dart'; // Import the user screen

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  StartScreenState createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  late TextEditingController usernameController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
  }

  void _navigateToUserScreen(String username) {
    User user = User(username);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const UserScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Enter a Username'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String username = usernameController.text.trim();
                if (username.isNotEmpty) {
                  _navigateToUserScreen(username);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a username')),
                  );
                }
              },
              child: const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}
