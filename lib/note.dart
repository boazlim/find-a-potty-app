import 'package:google_maps_flutter/google_maps_flutter.dart';

class Note{
  LatLng location;
  String rating, title, comment;

  Note(this.location, this.rating, this.title, this.comment);

  getLocation() => location;
  getRating() => rating;
  getTitle() => title;
  getComment() => comment;
}

List<Note>list = [];