import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ivote/App/constants.dart';
import 'package:ivote/App/routes.dart';
import 'package:ivote/App/voter_data.dart';

class VoterLoginView extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<VoterLoginView> {
  String _voterId, _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'I-Voting',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.how_to_vote_outlined),
              title: Text('Proof of Vote'),
              onTap: () {
                Navigator.pushNamed(context, Routes.proofOfVoteView);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Add admin'),
              onTap: () {
                Navigator.pushNamed(context, Routes.addAdminView);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Admin Login'),
              onTap: () {
                Navigator.pushNamed(context, Routes.adminLoginView);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Voter Signup'),
              onTap: () {
                Navigator.pushNamed(context, Routes.voterSignUpView);
              },
            ),
          ],
        ),
      ),
      key: Key(Routes.voterLoginView),
      backgroundColor: Color.fromRGBO(243, 243, 243, 100),
      body: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.only(top: 100.0, bottom: 0.0),
              //   child:
              Center(
                child: Container(
                  width: 250,
                  height: 150,
                  child: Image.asset(
                    'assets/images/voting_logo3.png',
                    scale: 0.09,
                  ),
                ),
              ),
              // ),
              Text('Voter Login'),
              Container(
                width: 300.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (voterId) {
                    if (voterId == null || voterId.isEmpty)
                      return 'Please Enter VoterId';
                    return null;
                  },
                  onSaved: (voterId) {
                    if (voterId != null || voterId.isNotEmpty)
                      _voterId = voterId;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Voter Id',
                      hintText: 'Enter valid voter id'),
                ),
              ),
              Container(
                width: 300.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) {
                    if (password == null || password.isEmpty)
                      return 'Please Enter Password';
                    return null;
                  },
                  onSaved: (password) {
                    if (password != null || password.isNotEmpty)
                      _password = password;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                ),
              ),
              TextButton(
                onPressed: () {
                  // ignore: todo
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                  Navigator.pushNamed(context, Routes.voterForgotPasswordView);
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 300,
                margin: EdgeInsets.symmetric(vertical: 35.0),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {
                    if (widget.formKey.currentState.validate()) {
                      widget.formKey.currentState.save();

                      print('Voter Id: $_voterId');
                      print('Password: $_password');

                      String jsonBody = json
                          .encode({'voterId': _voterId, 'password': _password});

                      http.Response response = await http.post(
                          Uri(
                            host: hostUrl,
                            port: hostUrlPort,
                            path: apiLogin,
                            // scheme: 'http',
                          ),
                          headers: postHeaders,
                          body: jsonBody);

                      print('RESPONSE: ');
                      print(response.body);

                      Map<String, dynamic> decodedJsonData =
                          jsonDecode(response.body);

                      if (decodedJsonData['isVoteCasted']) {
                        // ShowDialog
                        print('Vote ALready Casted');
                      } else {
                        extractVoterData(decodedJsonData);
                        Navigator.pushNamed(context, Routes.homeView);
                      }
                    } else
                      print('Validation Failed');
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 50,
              // ),
              Container(
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.voterSignUpView);
                    },
                    child: Text(
                      'New User? Create Account',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    )),
              )
              // Text('New User? Create Account')
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
              height: 40,
              padding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
              child: Text(
                "Made with ❤️ in India",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.lightBlue,
                ),
              ))),
    );
  }
}
