import 'dart:async';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class User {
  final int id;
  final String email;
  final String password;
  final String name;
  final String surname;
  final int type;
  final LatLng location;

  User(this.id, this.email, this.password, this.name, this.surname, this.type,
      this.location);
  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      json['id'],
      json['email'],
      json['password'],
      json['name'],
      json['surname'],
      json['type'],
      json['location'],
    );
  }
}
