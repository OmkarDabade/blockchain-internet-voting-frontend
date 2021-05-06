import 'package:flutter/material.dart';

void main() {
  runApp(IVote());
}

class IVote extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I-Vote',
      home: Center(
        child: Text('Flutter Demo Home Page'),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
