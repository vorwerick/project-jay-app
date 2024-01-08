import 'package:app/infrastructure/models/json/api_v1/api_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_registration_detail.g.dart';

@JsonSerializable()
class DeviceRegistrationDetail extends ApiResponse {
  final String? topic;

  DeviceRegistrationDetail(super.errorCode, super.description, this.topic);

  factory DeviceRegistrationDetail.fromJson(Map<String, dynamic> json) => _$DeviceRegistrationDetailFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceRegistrationDetailToJson(this);
}
