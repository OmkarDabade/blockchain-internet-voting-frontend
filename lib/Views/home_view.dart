import 'package:flutter/material.dart';

import '../App/location.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> _states = ["Choose a state"];
  List<String> _districts = ["Choose .."];
  String _selectedState = "Choose a state";
  String _selectedDistrict = "Choose ..";

  @override
  void initState() {
    _states = List.from(_states)..addAll(Location.getAllStates());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150.0,
            width: double.infinity,
            color: Colors.greenAccent,
            child: Row(
              children: [
                Container(
                  height: 50.0,
                  width: 200.0,
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  height: 50.0,
                  width: 200.0,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    items: _districts.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    // onChanged: (value) => print(value),
                    onChanged: (value) => _onSelectedDistrict(value),
                    value: _selectedDistrict,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => _candidateDetailsBlock(
                    candidateName: 'Candidate Name $index',
                    candidateParty: 'Candidate Party $index')),
          )
        ],
      ),
    );
  }

  void _onSelectedState(String value) {
    setState(() {
      _selectedDistrict = "Choose ..";
      _districts = ["Choose .."];
      _selectedState = value;
      _districts = List.from(_districts)
        ..addAll(Location.getLocalByState(value));
    });
  }

  void _onSelectedDistrict(String value) {
    setState(() => _selectedDistrict = value);
  }

  Widget _candidateDetailsBlock(
          {@required String candidateName, @required String candidateParty}) =>
      Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 100.0),
        padding: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(width: 0.9),
          color: Colors.blueGrey,
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.0,
              width: 150.0,
              margin: EdgeInsets.only(left: 50.0, right: 25.0),
              color: Colors.green,
              child: Icon(Icons.perm_contact_calendar_outlined),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Canidate Name: $candidateName'),
                  SizedBox(height: 15.0),
                  Text('Canidate\'s Party: $candidateParty'),
                  SizedBox(height: 15.0),
                  Container(
                    height: 100.0,
                    width: 100.0,
                    child: Icon(Icons.android_outlined),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              height: 60.0,
              width: 150.0,
              margin: EdgeInsets.all(50.0),
              child: ElevatedButton.icon(
                // style: ButtonStyle(),
                onPressed: () {},
                icon: Icon(Icons.thumb_up_alt_outlined),
                label: Text('Vote', style: TextStyle(fontSize: 21.0)),
              ),
            ),
          ],
        ),
      );
}
