import 'package:my_website_project/serviceRequests/apiCommunicator.dart';
import 'package:my_website_project/serviceRequests/jsonobjects/Camera.dart';

class ChuckCategoryRepository {
  ApiBaseHelper _provider = ApiBaseHelper();

  Future<Camera> fetchChuckCategoryData() async {
    final response = await _provider.get("jokes/categories");
    return Camera.fromMap(response);
  }
}
