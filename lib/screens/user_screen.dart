import 'package:flutter/material.dart';
import 'package:travel_routes/location.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  UserScreenState createState() => UserScreenState();
}
class UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Username'),
                  SizedBox(height: 8),
                  Text('Title')
                ],)
            ),
            ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${list[index].getTitle()}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('Rating: ${list[index].getRating()}'),
                      const SizedBox(height: 8),
                      Text('Comments: ${list[index].getComment()}'),
                    ],
                  ),
                );
              }
            ),
          ],
        )
      )
    );
  }
}