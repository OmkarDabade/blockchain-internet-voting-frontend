import 'package:flutter/material.dart';
import 'package:ivote/App/routes.dart';

class AddAdminView extends StatefulWidget {
  @override
  _AddAdminViewState createState() => _AddAdminViewState();
}

class _AddAdminViewState extends State<AddAdminView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key(Routes.addAdminView),
      backgroundColor: Color.fromRGBO(243, 243, 243, 100),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100.0, bottom: 0.0),
              child: Center(
                child: Container(
                  width: 250,
                  height: 150,
                  child: Image.asset(
                    'assets/images/voting_logo3.png',
                    scale: 0.09,
                  ),
                ),
              ),
            ),
            Text('Add Admin'),
            Container(
              width: 300.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
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
              child: TextField(
                obscureText: false,
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
              child: TextField(
                obscureText: true,
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
              child: TextField(
                obscureText: true,
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
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.addCandidateView);
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
