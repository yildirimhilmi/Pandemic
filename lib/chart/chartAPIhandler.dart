import 'dart:convert';

List<ChartApi> chartApiFromJson(String str) => List<ChartApi>.from(json.decode(str).map((x) => ChartApi.fromJson(x)));

String chartApiToJson(List<ChartApi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChartApi {
  ChartApi({
    this.id,
    this.imagePath,
    this.isLive,
    this.locationId,
    this.mask,
    this.sceneId,
    this.timestamp,
  });

  int id;
  String imagePath;
  int isLive;
  int locationId;
  int mask;
  int sceneId;
  String timestamp;

  factory ChartApi.fromJson(Map<String, dynamic> json) => ChartApi(
    id: json["id"],
    imagePath: json["image_path"],
    isLive: json["is_live"],
    locationId: json["location_id"],
    mask: json["mask"],
    sceneId: json["scene_id"],
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_path": imagePath,
    "is_live": isLive,
    "location_id": locationId,
    "mask": mask,
    "scene_id": sceneId,
    "timestamp": timestamp,
  };
}
