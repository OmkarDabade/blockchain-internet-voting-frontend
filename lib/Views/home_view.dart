import 'package:flutter/material.dart';
import 'package:ivote/App/routes.dart';

import '../App/location.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
      key: Key(Routes.homeView),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70.0,
            width: double.infinity,
            color: Colors.orange[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                    // onChanged: (value) => print(value),
                    onChanged: (value) => _onSelectedDistrict(value),
                    value: _selectedDistrict,
                  ),
                ),
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
                    // onChanged: (value) => print(value),
                    onChanged: (value) => _onSelectedWard(value),
                    value: _selectedWard,
                  ),
                ),
                Container(
                  height: 35.0,
                  width: 140.0,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      shadowColor: Colors.black,
                      elevation: 10,
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.search_sharp),
                    label: Text('Search', style: TextStyle(fontSize: 18.0)),
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
    setState(() => _selectedWard = value);
  }

  Widget _candidateDetailsBlock({
    @required String candidateName,
    @required String candidateParty,
  }) =>
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 200.0),
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(width: 0.9),
          color: Colors.green[200],
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.0,
              width: 130.0,
              margin: EdgeInsets.only(left: 50.0, right: 25.0),
              color: Colors.white70,
              child: Icon(Icons.person_outline_outlined),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 35.0),
                  Text('Candidate Name: $candidateName',
                      style: TextStyle(
                          fontSize: 21.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 25.0),
                  Text('Candidate\'s Party: $candidateParty',
                      style: TextStyle(fontSize: 21.0)),
                ],
              ),
            ),
            Spacer(),
            Container(
              // height: double.infinity,
              width: 150.0,
              // padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.android_outlined, size: 50.0),
                  SizedBox(height: 50.0),
                  Container(
                    height: 40.0,
                    width: 150.0,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                        onPrimary: Colors.white,
                        shadowColor: Colors.orange[400],
                        elevation: 10,
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.thumb_up_outlined),
                      label: Text('Vote', style: TextStyle(fontSize: 19.0)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
