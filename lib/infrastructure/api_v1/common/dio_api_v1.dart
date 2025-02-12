import 'dart:developer';

import 'package:app/infrastructure/api_v1/clients/rest_api_v1_client.dart';
import 'package:app/infrastructure/shared/info_plus_device_information_service.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

mixin DioApiV1 {
  RestApiV1Client? _client;

  @protected
  Future<RestApiV1Client> createClient() async {
    log("HEADERS: CLIENT " + (_client != null).toString());

    Dio dio = Dio();
    //dio.options.validateStatus = (d) => true;
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.receiveTimeout = const Duration(seconds: 20);
    dio.options.sendTimeout = const Duration(seconds: 20);
    log("HEADERS: DIO");
    final deviceInfo =
        await InfoPlusDeviceInformationService().createDeviceInformation();

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['JAY-AUTH'] = deviceInfo!.firebaseToken;
    dio.options.headers['MANUFACTURER'] = deviceInfo.manufacturer;
    dio.options.headers['DEVICE'] = deviceInfo.device;
    dio.options.headers['VERSION_NAME'] = deviceInfo.version;
    dio.options.headers['BUILD_NUMBER'] = deviceInfo.buildNumber;
    dio.options.headers['SDK'] = deviceInfo.sdk;

    log("HEADERS: " + dio.options.headers.toString());
    _client = RestApiV1Client(dio);
    return _client!;
  }
}
