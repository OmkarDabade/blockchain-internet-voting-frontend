import 'package:flutter/material.dart';
import 'package:ivote/App/routes.dart';
import 'package:intl/intl.dart';

class ForgotPasswordView extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  String _voterId, _adharNo, _district, _dob;
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
      key: Key(Routes.forgotPasswordView),
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
              Text('Forgot Password'),
              Container(
                width: 300.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (voterid) {
                    if (voterid == null || voterid.isEmpty)
                      return 'Please Enter voter ID';
                    return null;
                  },
                  onSaved: (voterid) {
                    if (voterid != null || voterid.isNotEmpty)
                      _voterId = voterid;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Voter ID',
                      hintText: 'Enter your voter ID'),
                ),
              ),
              Container(
                  width: 300.0,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    validator: (dob) {
                      if (dob == null || dob.isEmpty)
                        return 'Please Enter Date of Birth';
                      return null;
                    },
                    onSaved: (dob) {
                      if (dob != null || dob.isNotEmpty) _dob = dob;
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
                  validator: (adharno) {
                    if (adharno == null || adharno.isEmpty)
                      return 'Please Enter Adhar number';
                    return null;
                  },
                  onSaved: (adharno) {
                    if (adharno != null || adharno.isNotEmpty)
                      _adharNo = adharno;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Adhar Number',
                      hintText: 'Enter your adhar number'),
                ),
              ),
              Container(
                width: 300.0,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (district) {
                    if (district == null || district.isEmpty)
                      return 'Please Enter district';
                    return null;
                  },
                  onSaved: (district) {
                    if (district != null || district.isNotEmpty)
                      _district = district;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'District',
                      hintText: 'Enter your district'),
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
                      print('Name: $_voterId');
                      print('LoginId: $_adharNo');
                      print('DOB: $_dob');
                      print('Password: $_district');

                      print('Deatils Saved successfully');
                    } else
                      print('Validation Failed');
                  },
                  child: Text(
                    'Verify',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  // Navigator.pushNamed(context, Routes.homeView);
                ),
              ),
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
