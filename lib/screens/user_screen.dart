import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_routes/note.dart';
import 'package:travel_routes/main.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  UserScreenState createState() => UserScreenState();
}

class UserScreenState extends State<UserScreen> {

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
                  Text(
                    MyApp.username,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            ListView.builder(
              scrollDirection: Axis.vertical, //these 2 lines is what i added to fix the issue
              shrinkWrap: true,
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
              SizedBox(
                height: 120, // Replace with your desired height
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: list[index].getLocation(),
                    zoom: 15,
                  ),
                  myLocationButtonEnabled: false,
                  markers: {Marker(markerId: const MarkerId('placeholder'), 
                    icon: BitmapDescriptor.defaultMarker, 
                    position: list[index].getLocation()),}
                ),
              ),
    
    const SizedBox(height: 8),
    Text('Rating: ${list[index].getRating()}'),
    const SizedBox(height: 8),
    Text('Comments: ${list[index].getComment()}'),
  ],
),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
