import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse with EquatableMixin {
  @JsonKey(name: 'ErrorCode')
  final int errorCode;
  @JsonKey(name: 'Description')
  final String? description;

  ApiResponse(this.errorCode, this.description);

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  @override
  List<Object?> get props => [errorCode, description];

  @override
  bool? get stringify => true;
}
