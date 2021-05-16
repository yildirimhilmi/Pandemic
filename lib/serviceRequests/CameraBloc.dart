import 'dart:async';

import 'package:my_website_project/serviceRequests/jsonobjects/Camera.dart';

import 'CameraRepositor.dart';
import 'Response.dart';

class CameraBloc {
  CameraRepository _chuckRepository;
  StreamController _chuckListController;

  StreamSink<Response<Camera>> get chuckListSink => _chuckListController.sink;

  Stream<Response<Camera>> get chuckListStream => _chuckListController.stream;

  ChuckCategoryBloc() {
    _chuckListController = StreamController<Response<Camera>>();
    _chuckRepository = CameraRepository();
    fechCameras();
  }

  fechCameras() async {
    chuckListSink.add(Response.loading('Getting Chuck Categories.'));
    try {
      CameraRepository chuckCats = await CameraRepository.fetchCameraData();
      chuckListSink.add(Response.completed(chuckCats));
    } catch (e) {
      chuckListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _chuckListController?.close();
  }
}
