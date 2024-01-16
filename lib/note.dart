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

List<Note>list = [Note(LatLng(40.87824545058979, -73.89044287156874), '4', 'test', 'test')];