import 'package:flutter/material.dart';
import 'package:ivote/Views/add_candidate_view.dart';
import 'package:ivote/Views/admin_login_view.dart';
import 'package:ivote/Views/home_view.dart';
import 'package:ivote/Views/login_view.dart';
import 'package:ivote/Views/proof_of_vote_view.dart';
import 'package:ivote/Views/sign_up_view.dart';
import 'package:ivote/Views/add_admin_view.dart';
import 'package:ivote/Views/forgot_password_view.dart';

class Routes {
  static const home = '/';
  static const homeView = 'HomePage';
  static const loginView = 'LoginPage';
  static const proofOfVoteView = 'ProofOfVotePage';
  static const addCandidateView = 'AddCandidatePage';
  static const signUpView = 'SignUpPage';
  static const addAdminView = 'AddAdminPage';
  static const forgotPasswordView = 'ForgotPasswordPage';
  static const adminloginView = 'AdminLoginPage';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => LoginView(),
    homeView: (context) => HomeView(),
    loginView: (context) => LoginView(),
    proofOfVoteView: (context) => ProofOfVoteView(),
    addCandidateView: (context) => AddCandidateView(),
    signUpView: (context) => SignUpView(),
    addAdminView: (context) => AddAdminView(),
    forgotPasswordView: (context) => ForgotPasswordView(),
    adminloginView: (context) => AdminLoginView(),
  };
}
