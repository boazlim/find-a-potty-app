import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

// example code below:
class MapScreenState extends State<MapScreen>{

Location _locationController = new Location();

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

//initial position
  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

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
        markers: {
          Marker(markerId: MarkerId("_initialLocation"), 
          icon: BitmapDescriptor.defaultMarker, 
          position: _kGooglePlex),
          Marker(markerId: MarkerId("_currentlocation"), 
          icon: BitmapDescriptor.defaultMarker, 
          position: _currentP!)
        }
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('Bronx Science'),
        icon: const Icon(Icons.directions_boat),
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

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
