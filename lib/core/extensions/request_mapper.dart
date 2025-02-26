import 'package:fitora_mobile_app/core/base/base_params.dart';
import 'package:fitora_mobile_app/core/base/base_request.dart';

extension RequestMapper<T extends BaseParams> on T {
  BaseRequest toRequest() {
    return this.toRequest();
  }
}