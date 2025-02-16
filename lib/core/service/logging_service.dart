import 'package:flutter/foundation.dart';

class LoggingService {
  static void log(String message) {
    if(kDebugMode) {
      print("LOG: $message");
    }
  }

  static void logError(String error) {
    if(kDebugMode) {
      print("ERROR: $error");
    }
  }
}