import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location{
  LatLng location;
  int rating;
  String title, comment;

  Location(this.location, this.rating, this.title, this.comment);

  getLocation() => location;
  getRating() => rating;
  getTitle() => title;
  getComment() => comment;
}

List<Location>list = [];