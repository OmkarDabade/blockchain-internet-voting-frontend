import 'package:flutter/material.dart';
import 'package:ivote/App/routes.dart';
import 'package:ivote/Views/proof_of_vote_view.dart';
import 'add_admin_view.dart';

class LoginView extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
      key: Key(Routes.loginView),
      backgroundColor: Color.fromRGBO(243, 243, 243, 100),
      body: Form(
        key: widget.key,
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
                      return 'Please Enter Email';
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
                  Navigator.pushNamed(context, Routes.forgotPasswordView);
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
                  onPressed: () {
                    if (widget.formKey.currentState.validate()) {
                      print('Email: $_voterId');
                      print('Password: $_password');

                      print('Deatils Saved successfully');
                    } else
                      print('Validation Failed');

                    Navigator.pushNamed(context, Routes.homeView);
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
                      Navigator.pushNamed(context, Routes.signUpView);
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
