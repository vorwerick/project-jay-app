import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  @JsonKey(name: 'ErrorCode')
  final int errorCode;
  @JsonKey(name: 'Description')
  final String description;

  ApiResponse(this.errorCode, this.description);
}
