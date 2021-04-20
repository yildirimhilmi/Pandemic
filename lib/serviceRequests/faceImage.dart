import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FaceImage {
  final int id;
  final String image_path;
  final bool is_live;
  final int scene_id;
  final DateTime time;
  final int mask;

  FaceImage(this.id, this.image_path, this.is_live, this.scene_id, this.time,
      this.mask);
  factory FaceImage.fromMap(Map<String, dynamic> json) {
    return FaceImage(
      json['id'],
      json['image_path'],
      json['is_live'],
      json['scene_id'],
      json['timestamp'],
      json['mask'],
    );
  }
}
