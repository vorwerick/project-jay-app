import 'package:app/infrastructure/api_v1/models/json/api_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_registration_detail.g.dart';

@JsonSerializable()
class DeviceRegistrationDetail extends ApiResponse {
  final String? topic;

  DeviceRegistrationDetail(super.errorCode, super.description, this.topic);

  factory DeviceRegistrationDetail.fromJson(Map<String, dynamic> json) => _$DeviceRegistrationDetailFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceRegistrationDetailToJson(this);
}
