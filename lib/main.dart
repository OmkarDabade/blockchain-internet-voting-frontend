import 'package:flutter/material.dart';
import 'package:ivote/App/routes.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(IVote());
}

class IVote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I-Vote',
      initialRoute: Routes.adminloginView,
      routes: Routes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
