import 'package:flutter/material.dart';
import 'package:ivote/App/location.dart';
import 'package:ivote/App/routes.dart';

class AddCandidateView extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  _AddCandidateViewState createState() => _AddCandidateViewState();
}

class _AddCandidateViewState extends State<AddCandidateView> {
  String _candidateName, _candidateId;
  int _ward;

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
    _states = List.from(_states)..addAll(Location.getAllStates());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key(Routes.addCandidateView),
      body: Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 60.0, vertical: 50.0),
              child: Text(
                'Add Candidate',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 250.0,
                  width: 250.0,
                  color: Colors.grey[400],
                  child: Icon(Icons.person_outline_outlined),
                ),
                Container(
                  width: 500.0,
                  child: Column(
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (name) {
                          if (name == null || name.isEmpty)
                            return 'Please enter Candidate Name';

                          return null;
                        },
                        onSaved: (name) {
                          if (name != null || name.isNotEmpty)
                            _candidateName = name;
                        },
                        decoration: InputDecoration(
                          labelText: 'Candidate\'s Name',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.9),
                          ),
                          // contentPadding: EdgeInsets.all(4.0),
                        ),
                        scrollPadding: EdgeInsets.all(4.0),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (candidateId) {
                          if (candidateId == null || candidateId.isEmpty)
                            return 'Please enter Candidate Party';

                          return null;
                        },
                        onSaved: (candidateId) {
                          if (candidateId != null || candidateId.isNotEmpty)
                            _candidateId = candidateId;
                        },
                        decoration: InputDecoration(
                            labelText: 'Candidate\'s Id',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 0.9))),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 50.0,
                        width: 190.0,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: DropdownButton<String>(
                          isExpanded: true,
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
                      SizedBox(height: 10.0),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        height: 50.0,
                        width: 190.0,
                        child: DropdownButton<String>(
                          isExpanded: true,
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
                      SizedBox(height: 10.0),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        height: 50.0,
                        width: 190.0,
                        child: DropdownButton<String>(
                          isExpanded: true,
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
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 50.0,
              width: 350.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
              child: ElevatedButton.icon(
                style: ButtonStyle(),
                onPressed: () {
                  if (widget.formKey.currentState.validate()) {
                    print('Name: $_candidateName');
                    print('Id : $_candidateId');

                    print('State : $_selectedState');
                    print('District: $_selectedDistrict');
                    print('Ward : $_ward');

                    print('Deatils Saved successfully');
                  } else
                    print('Validation Failed');
                },
                icon: Icon(Icons.add),
                label: Text('Add Candidate', style: TextStyle(fontSize: 23.0)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
              height: 40,
              color: Colors.grey[50],
              padding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
              child: Text(
                "Made with ❤️ in India",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Colors.lightBlue),
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
    switch (value) {
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
    setState(() => _selectedWard = value);
  }
}
