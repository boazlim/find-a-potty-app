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

class User {
  String username;
  String title = 'Beginner';
  int toiletsRated = 0;

  User(this.username);

  String getUsername() => username;

  void addToilet() {
    toiletsRated++;
    updateTitle();
  }

  void updateTitle() {
    if (toiletsRated >= 1 && toiletsRated < 10) {
      title = 'Beginner';
    } else if (toiletsRated >= 10 && toiletsRated < 20) {
      title = 'Toilet Tourist';
    } else if (toiletsRated >= 20 && toiletsRated < 50) {
      title = 'Bathroom Baron';
    } else if (toiletsRated >= 50 && toiletsRated < 100) {
      title = 'Restroom Royalty';
    } else if (toiletsRated >= 100) {
      title = 'Toilet Tycoon';
    }
  }

  getTitle() {}
}

List<Location>list = [];