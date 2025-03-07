import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrl {
  ApiUrl._();

  static final String authUrl = dotenv.env['AUTH_URL'] ?? '';

  static final String userUrl = dotenv.env['USER_URL'] ?? '';

  static final String interactUrl = dotenv.env['INTERACT_URL'] ?? '';

  //static const baseUrl =  'http://localhost:5000';
  //static const androidUrl = 'http://10.0.2.2:5001';
  static const api = '/api/';

  // TODO: API AUTH SERVICE
  static const signIn = '${api}auth/login';
  static const signUp = '${api}auth/register';
  static const signOut = '${api}auth/logout';

  // TODO: API USER SERVICE - USER
  static const profile = '${api}user/profile';

  // TODO: API USER SERVICE - FRIENDSHIP
  static const addFriend = '${api}friendship/add-friend'; // API Gửi lời mời kết bạn
  static const acceptFriend ='${api}friendship/accept-friend-request'; // API Chấp nhận lời mời kết bạn
  static const friend = '${api}friendship/get-friends'; // API Danh sách bạn bè
  static const deleteFriend = '${api}friendship/delete-request'; // API Xóa bạn bè
  static const unfriend = '${api}friendship/unfriend'; // API hủy kết bạn
  static const getSentFriendRequests = '${api}friendship/get-sent-friend-requests'; // API Danh sách lời mời kết bạn đã gửi
  static const getReceivedFriendRequests = '${api}friendship/get-received-friend-requests'; // API  Danh sách lời mời kết bạn nhận được

  // TODO: API USER SERVICE - FOLLOW

  // TODO: API INTERACT SERVICE - POST
  static const newsFeed = '${api}post/newfeed';
  static const personal = '${api}post/personal';
  static const post = '${api}post/post';
  static const createPost = '${api}post/create-post';
  static const updatePost = '${api}post/update-post';
  static const deletePost = '${api}post/delete-post';

  // TODO: API INTERACT SERVICE - FILE
  static const upFile = '${api}';
}