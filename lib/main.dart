import 'package:flutter/material.dart';
import 'package:ivote/constants.dart';
import 'package:ivote/login_view.dart';

void main() {
  runApp(IVote());
}

class IVote extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I-Vote',
      initialRoute: LoginView.routeName,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
