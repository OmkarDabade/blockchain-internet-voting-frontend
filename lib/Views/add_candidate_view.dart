import 'package:flutter/material.dart';
import 'package:ivote/App/routes.dart';

class AddCandidateView extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  _AddCandidateViewState createState() => _AddCandidateViewState();
}

class _AddCandidateViewState extends State<AddCandidateView> {
  String _candidateName, _candidateParty, _candidateAgenda;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key(Routes.addCandidateView),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
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
                        if (name == null || name.isEmpty) _candidateName = name;
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
                      validator: (party) {
                        if (party == null || party.isEmpty)
                          return 'Please enter Candidate Party';
                        return null;
                      },
                      onSaved: (party) {
                        if (party == null || party.isEmpty)
                          _candidateParty = party;
                      },
                      decoration: InputDecoration(
                          labelText: 'Candidate\'s Party',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 0.9))),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (agenda) {
                        if (agenda == null || agenda.isEmpty)
                          return 'Please Enter Candidate agenda';
                        return null;
                      },
                      onSaved: (agenda) {
                        if (agenda == null || agenda.isEmpty)
                          _candidateAgenda = agenda;
                      },
                      // minLines: 3,
                      maxLines: 4,
                      decoration: InputDecoration(
                          labelText: 'Candidate\'s Agenda',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 0.9))),
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
                  print('Party: $_candidateParty');
                  print('Agenda: $_candidateAgenda');

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
}
