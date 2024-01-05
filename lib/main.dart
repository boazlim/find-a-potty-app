import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapSample()
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

// example code below:
class MapSampleState extends State<MapSample> {

Location _locationController = new Location();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

//initial position
  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

  static const LatLng _kGooglePlex = LatLng(37.4223, -122.0948);
  LatLng? _currentP = null;

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(40.87824545058979, -73.89044287156874),
      // tilt: 59.440717697143555,
      zoom: 19);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _kGooglePlex,
          zoom: 13
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        markers: {
          Marker(markerId: MarkerId("_currentlocation"), 
          icon: BitmapDescriptor.defaultMarker, 
          position: _kGooglePlex)
        }
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('Bronx Science'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> getLocationUpdates() async {
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
          
        }

    });
    
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
