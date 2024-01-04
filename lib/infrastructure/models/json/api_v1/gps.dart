import 'package:json_annotation/json_annotation.dart';

part 'gps.g.dart';

@JsonSerializable()
class Gps {
  @JsonKey(name: 'X')
  final double x;

  @JsonKey(name: 'Y')
  final double y;

  factory Gps.fromJson(Map<String, dynamic> json) => _$GpsFromJson(json);

  Gps(this.x, this.y);

  Map<String, dynamic> toJson() => _$GpsToJson(this);
}
