class ApiUrl {
  ApiUrl._();

  static const baseUrl =  'http://localhost:5000';
  static const androidUrl = 'http://10.0.2.2:5001';
  static const api = '/api/';

  static const signIn = '${api}auth/login';
  static const signUp = '${api}auth/register';
  static const signOut = '${api}auth/logout';

  static const profile = '${api}user/profile';

  static const postArticle = '${api}post/create-post';
  static const newsFeed = '${api}post/newfeed';
}