import 'package:flutter/material.dart';
import 'package:ivote/App/routes.dart';
import 'package:intl/intl.dart';

class VoterSignUpView extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<VoterSignUpView> {
  String _name, _gender, _voterId, _email, _password, _tempPass, _dateOfBirth;
//used for calendar
  TextEditingController dateinput = TextEditingController();
  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key(Routes.voterSignUpView),
      backgroundColor: Color.fromRGBO(243, 243, 243, 100),
      body: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 0.0),
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
              Text('Create a Voter Account'),

              Container(
                width: 300.0,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (name) {
                    if (name == null || name.isEmpty)
                      return 'Please Enter Name';
                    return null;
                  },
                  onSaved: (name) {
                    if (name != null || name.isNotEmpty) _name = name;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                      hintText: 'As per goverenment ID card'),
                ),
              ),

              Container(
                  width: 300.0,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (dob) {
                      if (dob == null || dob.isEmpty)
                        return 'Please Enter Date of Birth';
                      return null;
                    },
                    onSaved: (dob) {
                      if (dob != null || dob.isNotEmpty) _dateOfBirth = dob;
                    },
                    controller:
                        dateinput, //editing controller of this TextField
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Date of Birth"),
                    readOnly:
                        false, //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              1000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime.now() //DateTime(2101)
                          );

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          dateinput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  )),

              Container(
                width: 300.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (gender) {
                    if (gender == null || gender.isEmpty)
                      return 'Please Enter Gender';
                    return null;
                  },
                  onSaved: (gender) {
                    if (gender != null || gender.isNotEmpty) _gender = gender;
                  },
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
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (voterid) {
                    if (voterid == null || voterid.isEmpty)
                      return 'Please Enter Voter ID';
                    return null;
                  },
                  onSaved: (voterid) {
                    if (voterid != null || voterid.isNotEmpty)
                      _voterId = voterid;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Voter ID',
                    //hintText: ''
                  ),
                ),
              ),

              Container(
                width: 300.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) {
                    if (email == null || email.isEmpty)
                      return 'Please Enter Email';
                    return null;
                  },
                  onSaved: (email) {
                    if (email != null || email.isNotEmpty) _email = email;
                  },
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
                      _password = password;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
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
                      hintText: 'Re-enter Password'),
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
                      print('Name: $_name');
                      print('Date of Birth: $_dateOfBirth');
                      print('Gender: $_gender');
                      print('VoterID: $_voterId');
                      print('Email: $_email');
                      print('Password: $_password');

                      print('Deatils Saved successfully');
                    } else
                      print('Validation Failed');
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
                      Navigator.pushNamed(context, Routes.voterLoginView);
                    },
                    child: Text(
                      'Already have an account? Login',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    )),
              )
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
