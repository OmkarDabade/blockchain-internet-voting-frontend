import 'package:flutter/material.dart';
import 'package:ivote/App/routes.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Text('Create Your Account'),

            Container(
              width: 300.0,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                    hintText: 'As per goverenment ID card'),
              ),
            ),

            Container(
              width: 300.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Gender',
                    hintText: 'Male/Female'),
              ),
            ),

            Container(
              width: 300.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
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
                    hintText: 'Enter secure password'),
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
                  Navigator.pushNamed(context, Routes.homeView);
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => HomeView()));
                },
                child: Text(
                  'Sign Up',
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
                    Navigator.pushNamed(context, Routes.loginView);
                  },
                  child: Text(
                    'Already have an account? Login',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  )),
            )
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
