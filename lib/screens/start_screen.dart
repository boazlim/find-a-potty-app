import 'package:flutter/material.dart';
import 'package:travel_routes/main.dart';
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
                if (usernameController.text.isNotEmpty) {
                  MyApp.username = usernameController.text;
                  Navigator.pushReplacementNamed(context, '/map');
                } else {
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
