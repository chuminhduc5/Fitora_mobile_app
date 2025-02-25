import 'package:fitora_mobile_app/feature/post/domain/entities/post_entity.dart';

class PostModel {
  final String id;
  const PostModel({required this.id});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(id: json['id']);
  }

  PostEntity toEntity() {
    return PostEntity(id: id);
  }
}