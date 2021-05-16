import 'package:my_website_project/serviceRequests/apiCommunicator.dart';
import 'package:my_website_project/serviceRequests/jsonobjects/Camera.dart';

class CameraRepository {
  ApiBaseHelper _provider = ApiBaseHelper();

  Future<Camera> fetchCameraData() async {
    final response = await _provider.getAllCameras();
    return Camera.fromMap(response);
  }
}
