import 'package:flutter/material.dart';
import 'package:ivote/App/routes.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100.0, bottom: 50.0),
              child: Center(
                child: Text(
                  'I-Vote',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
            TextButton(
              onPressed: () {
                // ignore: todo
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
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
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            // SizedBox(
            //   height: 50,
            // ),
            Text('New User? Create Account')
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
              height: 40,
              child: Text(
                "Made with ♥ in India",
                textAlign: TextAlign.center,
              ))),
    );
  }
}
