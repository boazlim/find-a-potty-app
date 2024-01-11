import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_routes/location.dart';

class StartScreen extends StatefulWidget {
  const StartScreen ({super.key});

  @override
  StartScreenState createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  late TextEditingController usernameController;

  @override 

  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.Location.getTitle());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: TextField(
        controller: usernameController,
        decoration: const InputDecoration(labelText: 'Enter a Username'),
      )
    );
  }
}