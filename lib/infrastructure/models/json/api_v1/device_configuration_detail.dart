import 'package:app/infrastructure/models/json/api_v1/api_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_configuration_detail.g.dart';

@JsonSerializable()
class DeviceConfigurationDetail extends ApiResponse {
  @JsonKey(name: 'Items')
  final List<Item>? items;

  DeviceConfigurationDetail(super.errorCode, super.description, this.items);

  factory DeviceConfigurationDetail.fromJson(Map<String, dynamic> json) => _$DeviceConfigurationDetailFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceConfigurationDetailToJson(this);
}

@JsonSerializable()
class Item {
  final String key;
  final String value;

  Item(this.key, this.value);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
