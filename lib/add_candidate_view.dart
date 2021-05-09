import 'package:flutter/material.dart';

class AddCandidateView extends StatefulWidget {
  static const String routeName = 'add-candidate';
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
                color: Colors.grey,
                child: Icon(Icons.perm_contact_cal_outlined),
              ),
              Container(
                width: 500.0,
                child: Column(
                  children: [
                    TextField(),
                    TextField(),
                    TextField(
                      // minLines: 3,
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
            child: ElevatedButton.icon(
                onPressed: () {}, icon: Icon(Icons.add), label: Text('Add')),
          ),
        ],
      ),
    );
  }
}
