import 'package:json_annotation/json_annotation.dart';

part 'feedback.g.dart';

@JsonSerializable()
class Feedback {

  @JsonKey(name: 'Message')
  final String message;
  @JsonKey(name: 'ContactType')
  final int contactType;
  @JsonKey(name: 'Email')
  final String email;

  Feedback(this.email, this.contactType, this.message);

  factory Feedback.fromJson(final Map<String, dynamic> json) => _$FeedbackFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}
