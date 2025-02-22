import 'package:fitora_mobile_app/feature/home/doamin/entities/news_fees_entity.dart';

class NewsFeedModel {
  final String id;

  const NewsFeedModel({required this.id});

  factory NewsFeedModel.fromJson(Map<String, dynamic> json) {
    return NewsFeedModel(id: json['id']);
  }

  NewsFeedEntity toEntity() {
    return NewsFeedEntity(id: id);
  }
}