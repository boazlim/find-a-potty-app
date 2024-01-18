import 'package:flutter/material.dart';
import 'package:travel_routes/main.dart';
import 'package:travel_routes/note.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  StartScreenState createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showCreateAccountContainer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Potty Chronicles',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
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
                height: 100,
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      int userId = userExists(usernameController.text, passwordController.text);
                      if (userId != 0) {
                        MyApp.username = usernameController.text;
                        Navigator.pushReplacementNamed(context, '/map');
                      } else {
                        showAlertDialog(context, 'Invalid User or Wrong Password');
                      }
                    },
                    child: const Text('Submit'),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/create');
                    },
                    child: const Text('Create an Account'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int userExists(String username, String password) {
    for (int i = 0; i < users.length; i++) {
      if (username == users[i].getUsername() && password == users[i].getPassword()) {
        return users[i].getUserId();
      }
    }
    return 0;
  }

  Future<void> showAlertDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
