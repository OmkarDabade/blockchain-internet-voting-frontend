import 'package:flutter/material.dart';
import 'package:ivote/add_candidate_view.dart';
import 'package:ivote/home_view.dart';
import 'package:ivote/login_view.dart';
import 'package:ivote/proof_of_vote_view.dart';

Map<String, WidgetBuilder> routes = {
  HomeView.routeName: (context) => HomeView(),
  LoginView.routeName: (context) => LoginView(),
  ProofOfVote.routeName: (context) => ProofOfVote(),
  AddCandidateView.routeName: (context) => AddCandidateView(),
};

const String baseAPIUrl = '';
