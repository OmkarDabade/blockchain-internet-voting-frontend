import 'package:flutter/material.dart';
import 'package:ivote/add_candidate_view.dart';
import 'package:ivote/constants.dart';
import 'package:ivote/login_view.dart';
import 'package:ivote/proof_of_vote_view.dart';

void main() {
  runApp(IVote());
}

class IVote extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I-Vote',
      initialRoute: ProofOfVote.routeName,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
