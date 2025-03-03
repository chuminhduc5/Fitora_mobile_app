import 'package:fitora_mobile_app/core/constants/api_url.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/profile/data/models/responses/personal_model.dart';

abstract class PersonalRemoteDataSource {
  Future<PersonalModel> getPersonal();
}

class PersonalRemoteDataSourceImpl implements PersonalRemoteDataSource {
  final DioClient _dioClient;
  const PersonalRemoteDataSourceImpl(this._dioClient);
  @override
  Future<PersonalModel> getPersonal() async {
    try {
      var response = await _dioClient.get(ApiUrl.profile);
      final PersonalModel personal = PersonalModel.fromJson(response.data);
      return personal;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }
}