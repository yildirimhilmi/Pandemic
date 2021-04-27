import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Camera {
  final int id;

  final int location_id;

  Camera(this.id, this.location_id);
  factory Camera.fromMap(Map<String, dynamic> json) {
    return Camera(
      json['id'],
      json['location_id'],
    );
  }
}
