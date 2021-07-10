import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ivote/App/constants.dart';
import 'package:ivote/App/location.dart';
import 'package:ivote/App/routes.dart';
import 'package:intl/intl.dart';

class VoterSignUpView extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<VoterSignUpView> {
  String _state, _district;
  int _ward, _mobileNo;

  String _name, _gender, _voterId, _password, _tempPass, _dateOfBirth;
//used for calendar
  TextEditingController dateinput = TextEditingController();

  List<String> _states = ["Choose a state"];
  List<String> _districts = ["Choose a district"];
  List<String> _wards = [
    "Choose a ward",
    "Ward 1",
    "Ward 2",
    "Ward 3",
    "Ward 4",
    "Ward 5",
    "Ward 6"
  ];
  String _selectedState = "Choose a state";
  String _selectedDistrict = "Choose a district";
  String _selectedWard = "Choose a ward";

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    _states = List.from(_states)..addAll(Location.getAllStates());
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
                height: 70,
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
                    isDense: true,
                    icon: Icon(Icons.keyboard_arrow_down),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (state) {
                      if (state == "Choose a state")
                        return 'Please Select state';

                      return null;
                    },
                    onSaved: (state) {
                      if (state != null ||
                          state.isNotEmpty && state != "Choose a state")
                        _state = state;
                    },
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

              Container(
                height: 70.0,
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
                    isDense: true,
                    icon: Icon(Icons.keyboard_arrow_down),
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
                    value: _selectedDistrict,
                  ),
                ),
              ),

              Container(
                height: 70.0,
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
                    isDense: true,
                    icon: Icon(Icons.keyboard_arrow_down),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (ward) {
                      if (ward == "Choose a ward") return 'Please Select ward';

                      return null;
                    },
                    onSaved: (ward) {
                      print('SAved Ward');
                      print(ward);

                      if ((ward != null || ward.isNotEmpty) &&
                          ward != "Choose a ward") {
                        switch (ward) {
                          case "Ward 1":
                            _ward = 1;
                            break;
                          case "Ward 2":
                            _ward = 2;
                            break;
                          case "Ward 3":
                            _ward = 3;
                            break;
                          case "Ward 4":
                            _ward = 4;
                            break;
                          case "Ward 5":
                            _ward = 5;
                            break;
                          case "Ward 6":
                            _ward = 6;
                            break;
                        }
                      }
                    },
                    items: _wards.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (value) => _onSelectedWard(value),
                    value: _selectedWard,
                  ),
                ),
              ),

              Container(
                width: 300.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.phone,
                  validator: (mobileNo) {
                    if (mobileNo == null || mobileNo.isEmpty)
                      return 'Please Enter Mobile No.';
                    if (int.tryParse(mobileNo) == null)
                      return 'Please Enter only digits';
                    return null;
                  },
                  onSaved: (mobileNo) {
                    if (mobileNo != null || mobileNo.isNotEmpty)
                      _mobileNo = int.parse(mobileNo);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile No',
                      hintText: 'Enter valid mobile no'),
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
                  onPressed: () async {
                    if (widget.formKey.currentState.validate()) {
                      widget.formKey.currentState.save();

                      print('Name: $_name');
                      print('Date of Birth: $_dateOfBirth');
                      print('Gender: $_gender');
                      print('VoterID: $_voterId');

                      print('State: $_state');
                      print('District: $_district');
                      print('Ward: $_ward');

                      print('Mobile: $_mobileNo');
                      print('Password: $_password');

                      String jsonBody = json.encode({
                        'voterId': _voterId,
                        'name': _name,
                        'state': _state,
                        'district': _district,
                        'ward': _ward,
                        'mobile': _mobileNo,
                        'password': _password
                      });

                      http.Response response = await http.post(
                          Uri(
                            host: hostUrl,
                            port: hostUrlPort,
                            path: apiSignup,
                            // scheme: 'http',
                          ),
                          headers: postHeaders,
                          body: jsonBody);

                      print('RESPONSE: ');
                      print(response.body);

                      // Navigator.pushNamed(context, Routes.homeView);
                    } else
                      print('Validation Failed');
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

  void _onSelectedState(String value) {
    setState(() {
      _selectedDistrict = "Choose a district";
      _districts = ["Choose a district"];
      _selectedState = value;
      _districts = List.from(_districts)
        ..addAll(Location.getLocalByState(value));
    });
  }

  void _onSelectedDistrict(String value) {
    setState(() => _selectedDistrict = value);
  }

  void _onSelectedWard(String value) {
    setState(() => _selectedWard = value);
  }
}
