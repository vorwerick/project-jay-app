import 'package:app/infrastructure/api_v1/models/json/alarm/alarm_list.dart';
import 'package:app/infrastructure/api_v1/models/json/alarm/alarms.dart';
import 'package:app/infrastructure/api_v1/models/json/alarm_channel.dart';
import 'package:app/infrastructure/api_v1/models/json/alarm_confirmation/alarm_confirmation.dart';
import 'package:app/infrastructure/api_v1/models/json/alarm_confirmation/alarm_confirmation_detail.dart';
import 'package:app/infrastructure/api_v1/models/json/alarm_notification.dart';
import 'package:app/infrastructure/api_v1/models/json/api_response.dart';
import 'package:app/infrastructure/api_v1/models/json/device_configuration.dart';
import 'package:app/infrastructure/api_v1/models/json/device_configuration_detail.dart';
import 'package:app/infrastructure/api_v1/models/json/registration/device_registration.dart';
import 'package:app/infrastructure/api_v1/models/json/unit_detail.dart';
import 'package:app/infrastructure/api_v1/models/json/user/user_info.dart';
import 'package:app/infrastructure/api_v1/models/json/user_alarm.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_api_v1_client.g.dart';

@RestApi(baseUrl: 'https://jayserver.telwork.cz/Mobile.API')
abstract class RestApiV1Client {
  factory RestApiV1Client(Dio dio, {String baseUrl}) = _RestApiV1Client;

  @POST('/AlarmChannel')
  Future<ApiResponse> setAlarmChannel(@Body() AlarmChannel alarmChannel);

  @GET('/AlarmConfirmation/{id}')
  Future<HttpResponse<AlarmConfirmationDetail>> getAlarmConfirmationById(@Path('id') int id);

  @POST('/AlarmConfirmation')
  Future<ApiResponse> setAlarmConfirmation(@Body() AlarmConfirmation alarmConfirmation);

  @GET('/AlarmList')
  Future<HttpResponse<AlarmList>> getAlarmList();

  @GET('/AlarmList/{id}')
  Future<AlarmList> getAlarmListById(@Path('id') int id);

  @POST('/AlarmNotification')
  Future<ApiResponse> setAlarmNotification(@Body() AlarmNotification alarmNotification);

  @GET('/Alarms/{id}')
  Future<HttpResponse<Alarms>> getAlarmsById(@Path('id') int id);

  @POST('/DeviceConfiguration')
  Future<DeviceConfigurationDetail> setDeviceConfiguration(@Body() DeviceConfiguration deviceConfiguration);

  @POST('/DeviceRegistration')
  Future<HttpResponse<DeviceConfigurationDetail>> setDeviceRegistration(@Body() DeviceRegistration deviceRegistration);

  @GET('/UnitDetail')
  Future<UnitDetail> getUnitDetail();

  @PUT('/UserAlarm')
  Future<ApiResponse> addUserAlarm(@Body() UserAlarm userAlarm);

  @GET('/UserInfo')
  Future<HttpResponse<UserData>> getUserInfo();
}
