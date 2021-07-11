import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ivote/App/constants.dart';
import 'package:ivote/App/routes.dart';
import 'package:http/http.dart' as http;

class AddAdminView extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  _AddAdminViewState createState() => _AddAdminViewState();
}

class _AddAdminViewState extends State<AddAdminView> {
  String _adminName, _adminLoginId, _adminPassword, _tempPass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key(Routes.addAdminView),
      backgroundColor: Color.fromRGBO(243, 243, 243, 100),
      body: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
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
                // ),
              ),
              Text('Add Admin'),
              Container(
                width: 300.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (name) {
                    if (name == null || name.isEmpty)
                      return 'Please Enter Name';

                    return null;
                  },
                  onSaved: (name) {
                    if (name != null || name.isNotEmpty) _adminName = name;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter your name'),
                ),
              ),
              Container(
                width: 300.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // obscureText: true,
                  validator: (loginId) {
                    if (loginId == null || loginId.isEmpty)
                      return 'Please Enter loginId';

                    return null;
                  },
                  onSaved: (loginId) {
                    if (loginId != null || loginId.isNotEmpty)
                      _adminLoginId = loginId;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Login ID',
                      hintText: 'Enter your login ID'),
                ),
              ),
              Container(
                width: 300.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  validator: (password) {
                    if (password == null || password.isEmpty)
                      return 'Please Enter Password';

                    _tempPass = password;
                    return null;
                  },
                  onSaved: (password) {
                    if (password != null || password.isNotEmpty)
                      _adminPassword = password;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter your password'),
                ),
              ),
              Container(
                width: 300.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  validator: (confirmPassword) {
                    if (confirmPassword == null || confirmPassword.isEmpty)
                      return 'Please Enter Password';
                    if (_tempPass != confirmPassword)
                      return 'Password Doesnt match';

                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      hintText: 'Re-enter your password'),
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

                      print('Name: $_adminName');
                      print('LoginId: $_adminLoginId');
                      print('Password: $_adminPassword');

                      await requestServer();
                    } else
                      print('Validation Failed');
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 50,
              // ),
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
      String jsonBody = json.encode({
        'loginId': _adminLoginId,
        'name': _adminName,
        'password': _adminPassword
      });

      http.Response response = await http.post(
        Uri(
          host: hostUrl,
          port: hostUrlPort,
          path: apiSignup,
          // scheme: 'http',
        ),
        headers: postHeaders,
        body: jsonBody,
      );

      print('ADD ADMIN RESPONSE: ');
      print(response.body);

      Map<String, dynamic> decodedJsonData = jsonDecode(response.body);

      if (decodedJsonData['result']) {
        // ShowDialog
        print('Admin added Successfully');

        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Admin Registration Successful'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'))
            ],
          ),
        );

        widget.formKey.currentState.reset();
        Navigator.pushNamed(context, Routes.adminLoginView);
      } else {
        print('Failed to add admin');

        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Failed'),
                  content: Text(
                      'Registration Failed\n' + decodedJsonData['message'] ??
                          ''),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('OK'))
                  ],
                ));
      }
    } on SocketException {
      print('failed to add admin, network error');

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
      print('failed to add admin');

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
