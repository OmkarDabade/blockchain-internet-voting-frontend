import 'package:flutter/material.dart';

class AddCandidateView extends StatefulWidget {
  @override
  _AddCandidateViewState createState() => _AddCandidateViewState();
}

class _AddCandidateViewState extends State<AddCandidateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    TextField(
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
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Candidate\'s Party',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 0.9))),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
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
              onPressed: () {},
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
