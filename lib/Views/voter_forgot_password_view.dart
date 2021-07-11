import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ivote/App/constants.dart';
import 'package:ivote/App/location.dart';
import 'package:ivote/App/routes.dart';
// import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class VoterForgotPasswordView extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<VoterForgotPasswordView> {
  String _voterId,
      _name,
      // _dob,
      _newPassword,
      _tempPass;
  //used for calendar
  TextEditingController dateinput = TextEditingController();
  List<String> _states = ["Choose a state"];
  List<String> _districts = ["Choose a district"];

  String _selectedState = "Choose a state";
  String _district = "Choose a district";

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    _states = List.from(_states)..addAll(Location.getAllStates());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key(Routes.voterForgotPasswordView),
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
              // Container(
              //     width: 300.0,
              //     padding: const EdgeInsets.symmetric(vertical: 10.0),
              //     child: TextFormField(
              //       validator: (dob) {
              //         if (dob == null || dob.isEmpty)
              //           return 'Please Enter Date of Birth';
              //         return null;
              //       },
              //       onSaved: (dob) {
              //         if (dob != null || dob.isNotEmpty) _dob = dob;
              //       },
              //       controller:
              //           dateinput, //editing controller of this TextField
              //       decoration: InputDecoration(
              //           border: OutlineInputBorder(),
              //           labelText: "Date of Birth"),
              //       readOnly:
              //           false, //set it true, so that user will not able to edit text
              //       onTap: () async {
              //         DateTime pickedDate = await showDatePicker(
              //             context: context,
              //             initialDate: DateTime.now(),
              //             firstDate: DateTime(
              //                 1000), //DateTime.now() - not to allow to choose before today.
              //             lastDate: DateTime.now() //DateTime(2101)
              //             );

              //         if (pickedDate != null) {
              //           print(
              //               pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              //           String formattedDate =
              //               DateFormat('yyyy-MM-dd').format(pickedDate);
              //           print(
              //               formattedDate); //formatted date output using intl package =>  2021-03-16
              //           //you can implement different kind of Date Format here according to your requirement

              //           setState(() {
              //             dateinput.text =
              //                 formattedDate; //set output date to TextField value.
              //           });
              //         } else {
              //           print("Date is not selected");
              //         }
              //       },
              //     )),
              Container(
                width: 300.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (name) {
                    if (name == null || name.isEmpty)
                      return 'Please Enter your name';
                    return null;
                  },
                  onSaved: (name) {
                    if (name != null || name.isNotEmpty) _name = name;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter your Name as per Voter ID'),
                ),
              ),

              Container(
                // height: 70.0,
                width: 300.0,
                // margin: EdgeInsets.symmetric(horizontal: 10.0),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context)
                          .primaryTextTheme
                          .caption
                          .copyWith(color: Colors.black),
                      border: const OutlineInputBorder(),
                    ),
                    isExpanded: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (state) {
                      if (state == "Choose a state")
                        return 'Please Select state';

                      return null;
                    },
                    onSaved: (state) {},
                    items: _states.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (value) => _onSelectedState(value),
                    value: _selectedState,
                  ),
                ),
              ),
              // SizedBox(height: 10.0),
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 10.0),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                // height: 70.0,
                width: 300.0,
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context)
                          .primaryTextTheme
                          .caption
                          .copyWith(color: Colors.black),
                      border: const OutlineInputBorder(),
                    ),
                    isExpanded: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (district) {
                      if (district == "Choose a district")
                        return 'Please Select district';

                      return null;
                    },
                    onSaved: (district) {
                      if (district != null ||
                          district.isNotEmpty &&
                              district != "Choose a district")
                        _district = district;
                    },
                    items: _districts.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (value) => _onSelectedDistrict(value),
                    value: _district,
                  ),
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
                      _newPassword = password;
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

              // Container(
              //   width: 300.0,
              //   padding: const EdgeInsets.symmetric(vertical: 10.0),
              //   //padding: EdgeInsets.symmetric(horizontal: 15),
              //   child: TextFormField(
              //     autovalidateMode: AutovalidateMode.onUserInteraction,
              //     validator: (district) {
              //       if (district == null || district.isEmpty)
              //         return 'Please Enter district';
              //       return null;
              //     },
              //     onSaved: (district) {
              //       if (district != null || district.isNotEmpty)
              //         _district = district;
              //     },
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(),
              //         labelText: 'District',
              //         hintText: 'Enter your district'),
              //   ),
              // ),
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

                      print('Name: $_name');
                      print('VoterId: $_voterId');
                      print('District: $_district');
                      print('Password: : $_newPassword');

                      await requestServer();

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

  void _onSelectedState(String value) {
    setState(() {
      _district = "Choose a district";
      _districts = ["Choose a district"];
      _selectedState = value;
      _districts = List.from(_districts)
        ..addAll(Location.getLocalByState(value));
    });
  }

  void _onSelectedDistrict(String value) {
    setState(() => _district = value);
  }

  Future<void> requestServer() async {
    try {
      String jsonBody = json.encode({
        'voterId': _voterId,
        'name': _name,
        'district': _district,
        'newPassword': _newPassword,
      });

      http.Response response = await http.post(
        Uri(
          host: hostUrl,
          port: hostUrlPort,
          path: apiForgotPassword,
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
        print('Pass change Successful');

        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text(decodedJsonData['message']),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'))
            ],
          ),
        );

        widget.formKey.currentState.reset();
        Navigator.popUntil(context, ModalRoute.withName(Routes.voterLoginView));
      } else {
        print('Failed to change pass');

        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Failed'),
                  content: Text(decodedJsonData['message'] ?? ''),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('OK'))
                  ],
                ));
      }
    } on SocketException {
      print('failed to change password, network error');

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
      print('failed to change password');

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
