import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  static const String routeName = 'home-view';
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome'),
        ],
      ),
    );
  }
}
