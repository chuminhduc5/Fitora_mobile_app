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
  static const refreshToken = '${api}auth/refresh-token';
  static const getUserInfo = '${api}auth/me';

  // TODO: API USER SERVICE - USER
  static const profile = '${api}user/profile';
  static const updateProfile = '${api}user/update-user';
  static const getUsers = '${api}user/get-users';
  static const getUser = '${api}user/get-user';

  // TODO: API USER SERVICE - FRIENDSHIP
  static const addFriend = '${api}friendship/add-friend'; // API Gửi lời mời kết bạn
  static const acceptFriend ='${api}friendship/accept-friend-request'; // API Chấp nhận lời mời kết bạn
  static const friend = '${api}friendship/get-friends'; // API Danh sách bạn bè
  static const deleteFriend = '${api}friendship/delete-request'; // API Xóa bạn bè
  static const unfriend = '${api}friendship/unfriend'; // API hủy kết bạn
  static const getSentFriendRequests = '${api}friendship/get-sent-friend-requests'; // API Danh sách lời mời kết bạn đã gửi
  static const getReceivedFriendRequests = '${api}friendship/get-received-friend-requests'; // API  Danh sách lời mời kết bạn nhận được

  static const getRecommendUser = '${api}user/get-users';

  // TODO: API USER SERVICE - FOLLOW

  // TODO: API USER SERVICE - GROUP
  static const createGroup = '${api}group/create'; // Tạo nhóm
  static const updateGroup = '${api}group/update'; // Cập nhật nhóm
  static const deleteGroup = '${api}group/delete'; // Xóa nhóm
  static const getGroupById = '${api}group/get-by-id'; // Lấy nhóm theo id
  static const getListGroup = '${api}group/get-list'; // Lấy danh sách nhóm

  static const assignRoleMember = '${api}group/assign-role-member'; // Phân công vai trò thành viên trong nhóm
  static const getGroupMember = '${api}group/get-members'; // Lấy danh sách thành viên trong nhóm
  static const inviteNewMembers = '${api}group/invite-new-members'; // Mời thành viên vào nhóm

  static const getSentGroupInvite = '${api}group/get-sent-group-invites'; // Hiện thị danh sách lời mời thành viên vào nhóm
  static const getReceivedGroupInvite = '${api}group/get-received-group-invites'; // Hiện thị lời mời tham gia nhóm
  static const acceptGroupInvite = '${api}group/accept-group-invite'; // Chấp nhận lời mời tham gia nhóm
  static const deleteGroupInvite = '${api}group/delete-group-invite'; // Xóa lời mời nhóm

  // Group Posts: Create, Update, Delete
  static const createGroupPost = '${api}group/create-group-post';

  // Group Queries: Get managed and joined groups
  static const getManagedGroup = '${api}group/get-managed-groups';
  static const getJoinedGroup = '${api}group/get-joined-groups';

  // TODO: API INTERACT SERVICE - POST
  static const newsFeed = '${api}post/newfeed'; // Lấy bài viết trên newsfeed
  static const personal = '${api}post/personal'; // Lấy bài viết cá nhân
  static const getTrendingPost = '${api}post/trending-feed'; // Lấy bài viết trending
  static const getSavedPost = '${api}post/saved-posts'; // Lấy bài viết đã lưu
  static const getExplorePosts = '${api}post/explore-feed'; // Lấy bài viết khám phá
  static const post = '${api}post/post';
  static const createPost = '${api}post/create-post';
  static const updatePost = '${api}post/update-post';
  static const deletePost = '${api}post/delete-post';

  static const votePost = '${api}post/vote'; // Thực hiện upvote hoặc downvote bài viết
  static const savePost = '${api}post/save-post'; // Lưu bài viết
  static const unSavePost = '${api}post/unsave-post';

  // TODO: API INTERACT SERVICE - FILE
  static const uploadFile = '${api}Upload/file';

  // TODO: API INTERACT SERVICE - COMMENT
  static const getCommentByPost = '${api}comment/get-by-post';  // Lấy comment theo post
  static const getCommentReplies = '${api}comment/get-replies';  // Lấy comment con
  static const createComment =  '${api}comment/create';  // Tạo comment
  static const updateComment = '${api}comment/update';  // Cập nhật comment
  static const deleteComment = '${api}comment/delete';  // Xóa comment
  static const voteComment = '${api}comment/vote';  // Vote comment

  // TODO: API INTERACT SERVICE - Category
  static const getCategory = '${api}category/get-list';
  static const createCategory = '${api}category/create';
}