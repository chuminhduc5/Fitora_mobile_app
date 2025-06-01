import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrl {
  ApiUrl._();

  static final String authUrl = dotenv.env['AUTH_URL'] ?? '';

  static final String userUrl = dotenv.env['USER_URL'] ?? '';

  static final String interactUrl = dotenv.env['INTERACT_URL'] ?? '';

  //static const baseUrl =  'http://localhost:5000';
  //static const androidUrl = 'http://10.0.2.2:5001';
  //static const api = '/api';

  // TODO: API AUTH SERVICE
  static const signIn = '/auth/auth/login';
  static const signUp = '/auth/auth/register';
  static const signOut = '/auth/auth/logout';
  static const refreshToken = '/auth/auth/refresh-token';
  static const getUserInfo = '/auth/auth/me';

  // TODO: API USER SERVICE - USER
  static const profile = '/user/user/profile';
  static const updateProfile = '/user/user/update-user';
  static const getUsers = '/user/user/get-users';
  static const getUser = '/user/user/get-user';

  // TODO: API USER SERVICE - FRIENDSHIP
  static const addFriend = '/user/friendship/add-friend'; // API Gửi lời mời kết bạn
  static const acceptFriend ='/user/friendship/accept-friend-request'; // API Chấp nhận lời mời kết bạn
  static const friend = '/user/friendship/get-friends'; // API Danh sách bạn bè
  static const deleteFriend = '/user/friendship/delete-request'; // API Xóa bạn bè
  static const unfriend = '/user/friendship/unfriend'; // API hủy kết bạn
  static const getSentFriendRequests = '/user/friendship/get-sent-friend-requests'; // API Danh sách lời mời kết bạn đã gửi
  static const getReceivedFriendRequests = '/user/friendship/get-received-friend-requests'; // API  Danh sách lời mời kết bạn nhận được

  static const getRecommendUser = '/user/get-users';

  // TODO: API USER SERVICE - FOLLOW

  // TODO: API USER SERVICE - GROUP
  static const createGroup = '/user/group/create'; // Tạo nhóm
  static const updateGroup = '/user/group/update'; // Cập nhật nhóm
  static const deleteGroup = '/user/group/delete'; // Xóa nhóm
  static const getGroupById = '/user/group/get-by-id'; // Lấy nhóm theo id
  static const getListGroup = '/user/group/get-list'; // Lấy danh sách nhóm

  static const assignRoleMember = '/user/group/assign-role-member'; // Phân công vai trò thành viên trong nhóm
  static const getGroupMember = '/user/group/get-members'; // Lấy danh sách thành viên trong nhóm
  static const inviteNewMembers = '/user/group/invite-new-members'; // Mời thành viên vào nhóm

  static const getSentGroupInvite = '/user/group/get-sent-group-invites'; // Hiện thị danh sách lời mời thành viên vào nhóm
  static const getReceivedGroupInvite = '/user/group/get-received-group-invites'; // Hiện thị lời mời tham gia nhóm
  static const acceptGroupInvite = '/user/group/accept-group-invite'; // Chấp nhận lời mời tham gia nhóm
  static const deleteGroupInvite = '/user/group/delete-group-invite'; // Xóa lời mời nhóm

  // Group Posts: Create, Update, Delete
  static const createGroupPost = '/user/group/create-group-post';

  // Group Queries: Get managed and joined groups
  static const getManagedGroup = '/user/group/get-managed-groups';
  static const getJoinedGroup = '/user/group/get-joined-groups';

  // TODO: API INTERACT SERVICE - POST
  static const newsFeed = '/interact/post/newfeed'; // Lấy bài viết trên newsfeed
  static const personal = '/interact/post/personal'; // Lấy bài viết cá nhân
  static const getTrendingPost = '/interact/post/trending-feed'; // Lấy bài viết trending
  static const getSavedPost = '/interact/post/saved-posts'; // Lấy bài viết đã lưu
  static const getExplorePosts = '/interact/post/explore-feed'; // Lấy bài viết khám phá
  static const post = '/interact/post/post';
  static const createPost = '/interact/post/create-post';
  static const updatePost = '/interact/post/update-post';
  static const deletePost = '/interact/post/delete-post';

  static const votePost = '/interact/post/vote'; // Thực hiện upvote hoặc downvote bài viết
  static const savePost = '/interact/post/save-post'; // Lưu bài viết
  static const unSavePost = '/interact/post/unsave-post';

  // TODO: API INTERACT SERVICE - FILE
  static const uploadFile = '/interact/Upload/file';

  // TODO: API INTERACT SERVICE - COMMENT
  static const getCommentByPost = '/interact/comment/get-by-post';  // Lấy comment theo post
  static const getCommentReplies = '/interact/comment/get-replies';  // Lấy comment con
  static const createComment =  '/interact/comment/create';  // Tạo comment
  static const updateComment = '/interact/comment/update';  // Cập nhật comment
  static const deleteComment = '/interact/comment/delete';  // Xóa comment
  static const voteComment = '/interact/comment/vote';  // Vote comment

  // TODO: API INTERACT SERVICE - Category
  static const getCategory = '/interact/category/get-list';
  static const createCategory = '/interact/category/create';
  static const followCategory = '/interact/category/follow';
  static const unfollowCategory = '/interact/category/unfollow';
  static const getCategoryById = '/interact/category/get';
  static const getFollowed = '/interact/category/get-followed';
  static const getTrending = '/interact/category/get-trending';
}