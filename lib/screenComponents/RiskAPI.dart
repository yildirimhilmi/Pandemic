import 'dart:convert';

RiskApi riskApiFromJson(String str) => RiskApi.fromJson(json.decode(str));

String riskApiToJson(RiskApi data) => json.encode(data.toJson());

class RiskApi {
  RiskApi({
    this.beginTime,
    this.endTime,
    this.id,
    this.locationId,
    this.percentage,
    this.riskLevelId,
  });

  String beginTime;
  String endTime;
  int id;
  int locationId;
  double percentage;
  int riskLevelId;

  factory RiskApi.fromJson(Map<String, dynamic> json) => RiskApi(
    beginTime: json["begin_time"],
    endTime: json["end_time"],
    id: json["id"],
    locationId: json["location_id"],
    percentage: json["percentage"],
    riskLevelId: json["risk_level_id"],
  );

  Map<String, dynamic> toJson() => {
    "begin_time": beginTime,
    "end_time": endTime,
    "id": id,
    "location_id": locationId,
    "percentage": percentage,
    "risk_level_id": riskLevelId,
  };
}
