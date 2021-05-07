import 'package:flutter/material.dart';
import 'package:ivote/home_view.dart';
import 'package:ivote/login_view.dart';

Map<String, WidgetBuilder> routes = {
  HomeView.routeName: (context) => HomeView(),
  LoginView.routeName: (context) => LoginView(),
};

const String baseAPIUrl = '';
