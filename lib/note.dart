import 'package:google_maps_flutter/google_maps_flutter.dart';

class Note{
  LatLng location;
  double rating;
  String title, comment;

  Note(this.location, this.rating, this.title, this.comment);

  getLocation() => location;
  getRating() => rating;
  getTitle() => title;
  getComment() => comment;
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
List<Note>list = [];
List<Note>tempPosts = [];