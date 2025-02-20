import 'package:fitora_mobile_app/feature/profile/data/models/personal_model.dart';

abstract class PersonalRemoteDataSource {
  Future<PersonalModel> _getPersonal();
}

class PersonalRemoteDataSourceImpl extends PersonalRemoteDataSource {
  @override
  Future<PersonalModel> _getPersonal() {
    throw UnimplementedError();
  }
}