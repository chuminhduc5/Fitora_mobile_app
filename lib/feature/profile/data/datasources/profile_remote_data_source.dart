import 'package:fitora_mobile_app/feature/profile/data/models/responses/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> _getProfile();
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  @override
  Future<ProfileModel> _getProfile() {
    throw UnimplementedError();
  }
}