import 'package:app/infrastructure/api_v1/models/json/api_response.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_configuration_detail.g.dart';

@JsonSerializable()
class DeviceConfigurationDetail extends ApiResponse with EquatableMixin {
  @JsonKey(name: 'Items')
  final List<Item>? items;

  DeviceConfigurationDetail(super.errorCode, super.description, this.items);

  factory DeviceConfigurationDetail.fromJson(Map<String, dynamic> json) => _$DeviceConfigurationDetailFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceConfigurationDetailToJson(this);

  @override
  List<Object?> get props => [List.of(items ?? [])];

  @override
  // TODO: implement stringify
  bool? get stringify => true;
}

@JsonSerializable()
class Item {
  final String key;
  final String value;

  Item(this.key, this.value);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
