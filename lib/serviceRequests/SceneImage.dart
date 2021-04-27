import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SceneImage {
  final int id;
  final int scene_id;
  final int location_id;
  final DateTime timestamp;
  final String image;
  final bool is_live;
  final bool mask;

  SceneImage(this.id, this.scene_id, this.location_id, this.timestamp,
      this.image, this.is_live, this.mask);
  factory SceneImage.fromMap(Map<String, dynamic> json) {
    return SceneImage(
      json['id'],
      json['scene_id'],
      json['location_id'],
      json['timestamp'],
      json['image'],
      json['is_live'],
      json['mask'],
    );
  }
}
