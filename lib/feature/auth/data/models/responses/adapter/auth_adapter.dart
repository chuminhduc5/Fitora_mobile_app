import 'package:fitora_mobile_app/feature/auth/data/models/responses/auth_model.dart';
import 'package:hive/hive.dart';

// class AuthAdapter extends TypeAdapter<AuthModel> {
//   @override
//   final typeId = 4;
//
//   @override
//   AuthModel read(BinaryReader reader) {
//     final data = reader.readList();
//
//     return AuthModel(
//       user: data[0],
//       token: data[1],
//     );
//   }
//
//   @override
//   void write(BinaryWriter writer, AuthModel obj) {
//     writer.writeList([
//       obj.user,
//       obj.token,
//     ]);
//   }
// }
