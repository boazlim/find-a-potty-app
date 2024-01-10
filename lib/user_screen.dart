import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  UserScreenState createState() => UserScreenState();
}
class UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:
          Text('User'),
      ),
    );
  }
}