import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:travel_routes/note.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Set<Marker> _markers = {};
LatLng? _currentP;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen>{
  final Location _locationController = Location();
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  } 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null 
      ? const Center(
        child: Text("Loading..."),
        )  :
      GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _currentP!,
          zoom: 14
          ),
          myLocationButtonEnabled: false,
          onMapCreated: ((GoogleMapController controller) => _controller.complete(controller)),

        markers: _markers
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 25.0),
        child: InkWell(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return const NewMarkerWidget();
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(163, 64, 28, 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.warning, color: Colors.white),
                SizedBox(width: 10),
                Text("Poop Incoming!", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: pos, 
      zoom: 14
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged.listen((LocationData currentlocation) {
      if (currentlocation.latitude != null &&
        currentlocation.longitude != null) {
          setState(() {
            _currentP = LatLng(currentlocation.latitude!, currentlocation.longitude!);
          });
          _cameraToPosition(_currentP!);
        }
    });
  }

  getLatLng() => _currentP;
}

class NewMarkerWidget extends StatefulWidget {
  const NewMarkerWidget({super.key});

  @override
  NewMarkerWidgetState createState() => NewMarkerWidgetState();
}

class NewMarkerWidgetState extends State<NewMarkerWidget> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  double selectedRating = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Poop'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height:20),
          RatingBar.builder(
            initialRating: 1,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                selectedRating = rating;
              });
            },
          ),
          TextField(
            controller: commentController,
            decoration: const InputDecoration(labelText: 'Comment'),
          ),

          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              String title = titleController.text;
              double rating = selectedRating;
              String comment = commentController.text;
              Note newNote = Note(_currentP!, rating, title,  comment);
              setState(() {
                _markers.add(
                  Marker(
                    markerId: const MarkerId('placeholder'),
                    position: _currentP!,
                    infoWindow: InfoWindow(
                      title: title,
                      snippet: comment,
                    ),
                  )
                );
                list.add(newNote);
              });
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
           ),
        ],
      ),
    );
  }
}

