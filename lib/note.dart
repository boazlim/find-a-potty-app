import 'package:google_maps_flutter/google_maps_flutter.dart';

class Note{
  LatLng location;
  double rating;
  String title, comment;
  BitmapDescriptor icon;

  Note(this.location, this.rating, this.title, this.comment, this.icon);

  getLocation() => location;
  getRating() => rating;
  getTitle() => title;
  getComment() => comment;
  getIcon() => icon;
}

class User {
  static int _latestId = 1;
  int id;
  String username, password, bio, imagePath;

  User(this.username, this.password, this.bio, this.imagePath)
      : id = ++_latestId;

  getUsername() => username;
  getPassword() => password;
  getBio() => bio;
  getImagePath() => imagePath;
  getUserId() => id;
}

List<User>users = [];
List<Note>list = [Note(const LatLng(38.8977, -77.0365), 5, 'Pooping at the white house', 'met joe biden, feeling good', BitmapDescriptor.defaultMarker)];
List<Note>tempPosts = [];