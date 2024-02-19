import 'package:json_annotation/json_annotation.dart';

part 'fleet.g.dart';

@JsonSerializable()
class Fleet {
  @JsonKey(name: 'UnitName')
  final String? unitName;

  @JsonKey(name: 'FleetName')
  final String? fleetName;

  @JsonKey(name: 'FleetNickName')
  final String? fleetNickName;

  Fleet(this.unitName, this.fleetName, this.fleetNickName);

  factory Fleet.fromJson(Map<String, dynamic> json) => _$FleetFromJson(json);

  Map<String, dynamic> toJson() => _$FleetToJson(this);
}
