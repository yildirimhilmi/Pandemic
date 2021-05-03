import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_website_project/serviceRequests/jsonobjects/Camera.dart';
import 'package:my_website_project/serviceRequests/jsonobjects/Locations.dart';
import 'package:my_website_project/serviceRequests/jsonobjects/faceImage.dart';
import 'dart:convert';
import 'dart:async';
import 'exceptions.dart';

class ApiBaseHelper {
  final String _baseUrl =
      "http://localhost:55221"; // PATH TO LOCAL WİLL CAME HERE
  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> getCameraWitId(int id) async {
    String url = _baseUrl + "/$id";
    print('Api Get, url $url');
    Camera cameraResult;
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));
      responseJson = _returnResponse(response);
      cameraResult = Camera.fromMap(responseJson);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');

    return cameraResult;
  }

  Future<dynamic> getLocationWitId(int id) async {
    String url = _baseUrl + "/$id";
    print('Api Get, url $url');
    Location locationResult;
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));
      responseJson = _returnResponse(response);
      locationResult = Location.fromMap(responseJson);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');

    return locationResult;
  }

  Future<dynamic> getFaceWithId(int id) async {
    String url = _baseUrl + "/$id";
    print('Api Get, url $url');
    FaceImage faceImageResult;
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));
      responseJson = _returnResponse(response);
      faceImageResult = FaceImage.fromMap(responseJson);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');

    return faceImageResult;
  }

  Future<dynamic> getLocationWithCountry(String country) async {
    String url = _baseUrl + "/location/$country";
    print('Api Get, url $url');
    Location locationResult;
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));
      responseJson = _returnResponse(response);
      locationResult = Location.fromMap(responseJson);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');

    return locationResult;
  }

  Future<dynamic> getLocationWithCity(String city) async {
    String url = _baseUrl + "/location/$city";
    print('Api Get, url $url');
    Location locationResult;
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));
      responseJson = _returnResponse(response);
      locationResult = Location.fromMap(responseJson);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');

    return locationResult;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
