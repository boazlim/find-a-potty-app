import 'package:flutter/material.dart';

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Username'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Enter a Username'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Check if the username is not empty
                if (usernameController.text.isNotEmpty) {
                  // Navigate to MyApp if the username is entered
                  Navigator.pushReplacementNamed(context, '/map');
                } else {
                  // Show an error message or handle the case where username is empty
                  // For now, just print an error message to the console
                  print('Please enter a username.');
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}