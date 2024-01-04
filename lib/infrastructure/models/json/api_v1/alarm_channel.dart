import 'package:json_annotation/json_annotation.dart';

part 'alarm_channel.g.dart';

@JsonSerializable()
final class AlarmChannel {
  @JsonKey(name: 'AlarmChannel')
  final String alarmChannel;
  @JsonKey(name: 'DeviceKey')
  final String deviceKey;

  AlarmChannel(this.alarmChannel, this.deviceKey);

  factory AlarmChannel.fromJson(Map<String, dynamic> json) => _$AlarmChannelFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmChannelToJson(this);
}
