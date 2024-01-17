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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Potty Chronicles',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )
        ),
        backgroundColor: const Color.fromARGB(255, 203, 85, 42),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Center(
              child: Image.asset(
                'images/poop.jpg',
                height: 150,
              ),
            ),
            const SizedBox(height: 70),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Enter a Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (usernameController.text.isNotEmpty) {
                  MyApp.username = usernameController.text;
                  Navigator.pushReplacementNamed(context, '/map');
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
