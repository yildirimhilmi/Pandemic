import 'dart:async';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class Location {
  final int id;
  final String country;
  final String city;
  final String street;
  final double latitude;
  final double longitude;

  Location(this.id, this.country, this.city, this.street, this.latitude,
      this.longitude);
  factory Location.fromMap(Map<String, dynamic> json) {
    return Location(
      json['id'],
      json['country'],
      json['city'],
      json['street'],
      json['latitude'],
      json['longitude'],
    );
  }
}
