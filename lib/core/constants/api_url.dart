class ApiUrl {
  ApiUrl._();

  static const baseUrl =  'http://localhost:5000';
  static const androidUrl = 'http://10.0.2.2:5001';
  static const api = '/api/';

  static const signIn = '${api}auth/login';
  static const signUp = '${api}auth/register';
  static const signOut = '${api}auth/logout';

  static const profile = '${api}user/profile';

  static const newsFeed = '${api}post/newfeed';
  static const personal = '${api}post/personal';
  static const post = '${api}post/post';
  static const createPost = '${api}post/create-post';
  static const updatePost = '${api}post/update-post';
  static const deletePost = '${api}post/delete-post';
}