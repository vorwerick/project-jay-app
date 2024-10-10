import 'package:json_annotation/json_annotation.dart';

part 'func.g.dart';

@JsonSerializable()
final class Func {
  @JsonKey(name: 'Id')
  final int id;
  @JsonKey(name: 'FunctionName')
  final String functionName;
  @JsonKey(name: 'FireSystem')
  final bool? fireSystem;
  @JsonKey(name: 'FunctionIndex')
  final int? functionIndex;

  Func({required this.id, required this.functionName, required this.fireSystem,required this.functionIndex});

  factory Func.fromJson(final Map<String, dynamic> json) => _$FuncFromJson(json);

  Map<String, dynamic> toJson() => _$FuncToJson(this);
}

