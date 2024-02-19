import 'package:app/application/shared/device_information.dart';
import 'package:app/infrastructure/api_v1/clients/rest_api_v1_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

mixin DioApiV1 {
  RestApiV1Client? _client;

  Future<RestApiV1Client> createClient() async {
    if (_client != null) {
      return _client!;
    }
    Dio dio = Dio();

    final deviceInfo = await GetIt.I.getAsync<DeviceInformation>();

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['MANUFACTURER'] = deviceInfo.manufacturer;
    dio.options.headers['DEVICE'] = deviceInfo.device;
    dio.options.headers['VERSION_NAME'] = deviceInfo.version;
    dio.options.headers['BUILD_NUMBER'] = deviceInfo.buildNumber;
    dio.options.headers['SDK'] = deviceInfo.sdk;
    dio.options.headers['JAY-AUTH'] = deviceInfo.firebaseToken;

    _client = RestApiV1Client(dio);
    return _client!;
  }
}
