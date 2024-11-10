// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feedback _$FeedbackFromJson(Map<String, dynamic> json) => Feedback(
      json['Email'] as String,
      (json['ContactType'] as num).toInt(),
      json['Message'] as String,
    );

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
      'Message': instance.message,
      'ContactType': instance.contactType,
      'Email': instance.email,
    };
