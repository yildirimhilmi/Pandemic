import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class LocationRiskLevel {
  final int id;
  final Float latitude;
  final Float longitude;
  final Float risk_level;
  final DateTime begin_time;
  final DateTime end_time;

  LocationRiskLevel(this.id, this.latitude, this.longitude, this.risk_level,
      this.begin_time, this.end_time);
  factory LocationRiskLevel.fromMap(Map<String, dynamic> json) {
    return LocationRiskLevel(
      json['id'],
      json['latitude'],
      json['longitude'],
      json['risk_level'],
      json['begin_time'],
      json['end_time'],
    );
  }
}
