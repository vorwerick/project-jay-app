import 'dart:developer';

import 'package:app/infrastructure/api_v1/models/json/api_response.dart';
import 'package:app/infrastructure/api_v1/validation/validation.dart';
import 'package:retrofit/dio.dart';

final class ApiResponseValidation extends Validation<HttpResponse<ApiResponse>> {
  ApiResponseValidation(super.data);

  @override
  bool isValid() {
    if (data.response.statusCode != 200) {
      log('Response status code is not 200 but: ${data.response.statusCode}, ${data.data}',
          name: 'ApiResponseValidation');
      return false;
    }

    if (data.data.errorCode != 0) {
      log('Response contains error code: ${data.data.errorCode}', name: 'ApiResponseValidation');
      return false;
    }

    return true;
  }
}
