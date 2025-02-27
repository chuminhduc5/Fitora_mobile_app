import 'package:fitora_mobile_app/core/base/base_params.dart';
import 'package:fitora_mobile_app/core/base/base_request.dart';

extension ParamsToRequestMapper<T extends BaseParams, R extends BaseRequest> on T {
  R toRequest(R Function(Map<String, dynamic>) constructor) {
    return constructor(toJson());
  }
}