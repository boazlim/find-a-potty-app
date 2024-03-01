import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_routes/note.dart';
import 'package:travel_routes/main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  UserScreenState createState() => UserScreenState();
}

class UserScreenState extends State<UserScreen> {

  BitmapDescriptor? customIcon;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage('https://i.pinimg.com/736x/a8/57/00/a85700f3c614f6313750b9d8196c08f5.jpg'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    MyApp.username,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    users[0].getBio(),
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                signOut(); // Call the signOut function to log out the user
                Navigator.of(context).pushNamed('/start'); // Navigate back to the login screen
              },
            ),

            Expanded(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${list[index].getTitle()}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 120,
                          child: GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                              target: list[index].getLocation(),
                              zoom: 15,
                            ),
                            myLocationButtonEnabled: false,
                            markers: {
                              Marker(
                                markerId: const MarkerId('placeholder'),
                               // icon: list[index].getIcon(), its too big, fix later
                                position: list[index].getLocation(),
                              ),
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        RatingBar.builder(
                          initialRating: list[index].getRating(),
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: 20,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (double rating) {},
                        ),
                        const SizedBox(height: 10),
                        Text('${list[index].getComment()}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
void signOut() async {
  await FirebaseAuth.instance.signOut();
}