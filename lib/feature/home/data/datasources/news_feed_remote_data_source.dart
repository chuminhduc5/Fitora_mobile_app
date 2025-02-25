import 'package:fitora_mobile_app/feature/home/data/models/news_feed_model.dart';

abstract class NewsFeedRemoteDataSource {
  Future<List<NewsFeedModel>> _fetchNewsFeed();
}

class NewsFeedRemoteDataSourceImpl extends NewsFeedRemoteDataSource {
  @override
  Future<List<NewsFeedModel>> _fetchNewsFeed() async {
    throw UnimplementedError();
  }
}