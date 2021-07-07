import 'package:flutter/material.dart';
import 'package:ivote/Views/add_candidate_view.dart';
import 'package:ivote/Views/admin_login_view.dart';
import 'package:ivote/Views/home_view.dart';
import 'package:ivote/Views/voter_login_view.dart';
import 'package:ivote/Views/proof_of_vote_view.dart';
import 'package:ivote/Views/voter_sign_up_view.dart';
import 'package:ivote/Views/add_admin_view.dart';
import 'package:ivote/Views/forgot_password_view.dart';

class Routes {
  static const home = '/';
  static const homeView = 'HomePage';
  static const voterLoginView = 'VoterLoginPage';
  static const proofOfVoteView = 'ProofOfVotePage';
  static const addCandidateView = 'AddCandidatePage';
  static const voterSignUpView = 'VoterSignUpPage';
  static const addAdminView = 'AddAdminPage';
  static const forgotPasswordView = 'ForgotPasswordPage';
  static const adminLoginView = 'AdminLoginPage';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => VoterLoginView(),
    homeView: (context) => HomeView(),
    voterLoginView: (context) => VoterLoginView(),
    proofOfVoteView: (context) => ProofOfVoteView(),
    addCandidateView: (context) => AddCandidateView(),
    voterSignUpView: (context) => VoterSignUpView(),
    addAdminView: (context) => AddAdminView(),
    forgotPasswordView: (context) => ForgotPasswordView(),
    adminLoginView: (context) => AdminLoginView(),
  };
}
