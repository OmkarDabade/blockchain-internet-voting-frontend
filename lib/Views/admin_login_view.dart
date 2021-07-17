import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ivote/App/admin_data.dart';
import 'package:ivote/App/constants.dart';
import 'package:ivote/App/routes.dart';
import 'package:ivote/Views/proof_of_vote_view.dart';
import 'add_admin_view.dart';

class AdminLoginView extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  _AdminLoginViewState createState() => _AdminLoginViewState();
}

class _AdminLoginViewState extends State<AdminLoginView> {
  String _loginId, _password;

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProofOfVoteView()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Add admin'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddAdminView()),
                );
              },
            ),
          ],
        ),
      ),
      key: Key(Routes.adminLoginView),
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
              Text('Admin Login'),
              Container(
                width: 300.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (loginid) {
                    if (loginid == null || loginid.isEmpty)
                      return 'Please Enter Login ID';
                    return null;
                  },
                  onSaved: (loginid) {
                    if (loginid != null || loginid.isNotEmpty)
                      _loginId = loginid;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Login ID',
                      hintText: 'Enter your Login ID'),
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

                      print('LoginId: $_loginId');
                      print('Password: $_password');

                      await requestServer();
                    } else
                      print('Validation Failed');
                  },
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => HomeView()));

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
                      Navigator.pushNamed(context, Routes.addAdminView);
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

  Future<void> requestServer() async {
    try {
      String jsonBody =
          json.encode({'loginId': _loginId, 'password': _password});

      http.Response response = await http.post(
        Uri(
          host: hostUrl,
          port: hostUrlPort,
          path: apiLogin,
          // scheme: 'http',
        ),
        headers: postHeaders,
        body: jsonBody,
      );

      print('RESPONSE: ');
      print(response.body);

      Map<String, dynamic> decodedJsonData = jsonDecode(response.body);

      if (decodedJsonData['result']) {
        // ShowDialog
        print('Admin Login Successful');
        extractAdminData(decodedJsonData);

        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Login Successful'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'))
            ],
          ),
        );

        widget.formKey.currentState.reset();
        Navigator.pushNamed(context, Routes.addCandidateView);
      } else {
        print('Failed to login admin');

        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Failed'),
                  content:
                      Text('Login Failed\n' + decodedJsonData['message'] ?? ''),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('OK'))
                  ],
                ));
      }
    } on SocketException {
      print('failed to load chain data, network error');

      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Network Error'),
                content: Text(
                    "Connection Error, Please check your internet connection"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('RETRY'))
                ],
              ));
    } catch (error) {
      print('failed to load chain data');

      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Error Occured'),
                content: Text(error.toString()),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('RETRY'))
                ],
              ));
    }
  }
}
