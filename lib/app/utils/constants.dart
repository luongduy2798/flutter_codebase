import 'package:flutter/material.dart';

class Constants {
  static const String baseUrl = 'https://api.innogissoft.com';
  static const int connectTimeout = 10000; // 10 seconds
  static const int receiveTimeout = 10000; // 10 seconds
  static const bool loggingInterceptorEnabled = true;
}

enum LoadDataState { initialize, loading, loaded, error, timeout, unknownerror }

final GlobalKey<ScaffoldState> scaffoldMainKey = GlobalKey<ScaffoldState>();
