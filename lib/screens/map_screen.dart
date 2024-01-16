import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:travel_routes/note.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen>{

  Location _locationController = new Location();
  Set<Marker> _markers = {};

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const LatLng _kGooglePlex = LatLng(37.4223, -122.0948);
  LatLng? _currentP = null;

  @override
  void initState() { //required to prompt for user's location
    super.initState();
    getLocationUpdates();
  } 
  

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(40.87824545058979, -73.89044287156874),
      // tilt: 59.440717697143555,
      zoom: 19);

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
          zoom: 9
          ),
          onMapCreated: ((GoogleMapController controller) => _controller.complete(controller)),
          // onMapCreated: (GoogleMapController controller) {
          //   _controller.complete(controller);
          // },
        markers: _markers
          // Marker(markerId: MarkerId("_initialLocation"), 
          // icon: BitmapDescriptor.defaultMarker, 
          // position: _kGooglePlex),
          // Marker(markerId: MarkerId("_currentlocation"), 
          // icon: BitmapDescriptor.defaultMarker, 
          // position: _currentP!)
        
      ),
      floatingActionButton: FloatingActionButton(
       onPressed: () async {
         await showDialog(
           context: context,
           builder: (BuildContext context) {
             return const NewMarkerWidget();
           },
         );
         setState(() {});
       },
       child: const Icon(Icons.add),
     ),
     
    );
    
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos, 
      zoom: 13
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async { //required to obtain location.
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
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
  /*Future<void> _goToTheLake() async {
    _addMarker('1', LatLng(40.87824545058979, -73.89044287156874));
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
  */
  void _addMarker(String id, LatLng position, String title, String description) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(id),
          position: position,
          infoWindow: InfoWindow(
            title: title,
            snippet: description,
          ),
        )
      );
    });
  }
}

class NewMarkerWidget extends StatefulWidget {
 const NewMarkerWidget({super.key});


  @override
  NewMarkerWidgetState createState() => NewMarkerWidgetState();
}


class NewMarkerWidgetState extends State<NewMarkerWidget> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Note'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: ratingController,
            decoration: const InputDecoration(labelText: 'rating'),
          ),
          TextField(
            controller: commentController,
            decoration: const InputDecoration(labelText: 'Comment'),
          ),

          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              String title = titleController.text;
              String rating = ratingController.text;
              String comment = commentController.text;
              Note newNote = Note(rating, title,  comment)
              setState(() {
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

