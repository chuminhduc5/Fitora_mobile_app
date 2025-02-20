import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  ApiConstant._();

  static const baseUrl =  'http://localhost:5000';
  static const androidUrl = 'http://10.0.2.2:5001';
  static const api = '/api/';

  static const signIn = '${api}auth/login';
  static const signUp = '${api}auth/register';
  static const signOut = '${api}auth/logout';
}