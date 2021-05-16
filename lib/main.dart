import 'package:flutter/material.dart';
import 'package:ivote/App/routes.dart';

void main() {
  runApp(IVote());
}

class IVote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I-Vote',
      initialRoute: Routes.loginView,
      routes: Routes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
