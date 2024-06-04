import 'package:app/application/extensions/l.dart';
import 'package:app/infrastructure/api_v1/models/json/api_response.dart';
import 'package:app/infrastructure/api_v1/validation/validation.dart';
import 'package:retrofit/dio.dart';

final class ApiResponseValidation extends Validation<HttpResponse<ApiResponse>> with L {
  ApiResponseValidation(super.data);

  @override
  bool get isValid => _isValid();

  bool _isValid() {
    if (data.response.statusCode != 200) {
      l.w('Response status code is not 200 but: ${data.response.statusCode}, ${data.data}');
      return false;
    }

    if (data.data.errorCode != 0) {
      l.w('Response contains error code: ${data.data.errorCode} with message: ${data.data.description}');
      return false;
    }

    return true;
  }
}
