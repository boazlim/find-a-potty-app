import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_routes/note.dart';
import 'package:travel_routes/main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
                  const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage('data:image/png;base64,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'),
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
                                icon: BitmapDescriptor.defaultMarker,
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
