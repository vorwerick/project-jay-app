import 'package:app/infrastructure/api_v1/models/json/api_response.dart';
import 'package:app/infrastructure/api_v1/models/json/gps.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit_detail.g.dart';

@JsonSerializable()
class UnitDetail extends ApiResponse {
  final Detail? unitDetail;

  UnitDetail(super.errorCode, super.description, this.unitDetail);

  factory UnitDetail.fromJson(Map<String, dynamic> json) => _$UnitDetailFromJson(json);

  Map<String, dynamic> toJson() => _$UnitDetailToJson(this);
}

@JsonSerializable()
class Detail {
  @JsonKey(name: 'Id')
  final int id;
  @JsonKey(name: 'GroupName')
  final String groupName;

  @JsonKey(name: 'GroupNumber')
  final String GroupNumber;

  @JsonKey(name: 'FiraStationGps')
  final Gps firaStationGps;

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);

  Detail(this.id, this.groupName, this.GroupNumber, this.firaStationGps);

  Map<String, dynamic> toJson() => _$DetailToJson(this);
}
