import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

class RiskLevel {
  final int id;
  final int color;
  final Float upper_bound;

  RiskLevel(this.id, this.color, this.upper_bound);
  factory RiskLevel.fromMap(Map<String, dynamic> json) {
    return RiskLevel(
      json['id'],
      json['color'],
      json['upper_bound'],
    );
  }
}
