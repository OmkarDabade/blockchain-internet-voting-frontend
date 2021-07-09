import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ivote/App/constants.dart';
import 'package:ivote/App/routes.dart';
import 'package:ivote/App/voter_data.dart';
import 'package:ivote/Views/proof_of_vote_view.dart';
import 'package:http/http.dart' as http;
import 'package:ivote/model/candidate.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Candidate> candidateList;
  Map<String, dynamic> candidateListInJson;
  bool isLoaded;

  @override
  void initState() {
    isLoaded = false;
    candidateList = [];
    getCandidateList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'I-Voting',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.how_to_vote_outlined),
              title: Text('Proof of Vote'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProofOfVoteView()),
                );
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.account_circle),
            //   title: Text('Add admin'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => AddAdminView()),
            //     );
            //   },
            // ),
          ],
        ),
      ),
      key: Key(Routes.homeView),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoaded
              ? candidateList.isEmpty
                  ? Center(
                      child: Text('No Candidates in your ward'),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: candidateList.length,
                          itemBuilder: (context, index) =>
                              _candidateDetailsBlock(
                                candidateName:
                                    candidateList[index].candidateName,
                                candidateId: candidateList[index].candidateId,
                              )),
                    )
              : Center(
                  child: CircularProgressIndicator(),
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

  Widget _candidateDetailsBlock({
    @required String candidateName,
    @required int candidateId,
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
                  Text('Candidate Id: $candidateId',
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
                      onPressed: () async {
                        String jsonBody = json.encode({
                          'candidateId': candidateId,
                          'candidateName': candidateName,
                          'voterId': kVoterId,
                        });

                        http.Response response = await http.post(
                            Uri(
                              host: hostUrl,
                              port: hostUrlPort,
                              path: apiCastVote,
                              // scheme: 'http',
                            ),
                            headers: postHeadersWithJWT(kVoterJWTToken),
                            body: jsonBody);

                        print('RESPONSE: ');
                        print(response.body);
                      },
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

  void getCandidateList() async {
    print('Get cAndiates called');

    candidateList = [];
    Map<String, dynamic> jsonData = {};

    if (kState != null && kState.isNotEmpty) jsonData['state'] = kState;
    if (kDistrict != null && kDistrict.isNotEmpty)
      jsonData['district'] = kDistrict;
    if (kWard != null) jsonData['ward'] = kWard;

    print('requesting server');

    http.Response response = await http.post(
        Uri(
          // queryParameters: jsonData,
          host: hostUrl,
          port: hostUrlPort,
          path: apiGetCandidates,
          // scheme: 'http',
        ),
        headers: postHeadersWithJWT(kVoterJWTToken),
        body: json.encode(jsonData));

    print('GET CANDIDATES RESPONSE: ');
    print(response.body);

    candidateListInJson = jsonDecode(response.body);

    if (candidateListInJson['result'] != null &&
        candidateListInJson['result']) {
      for (Map<String, dynamic> vote in candidateListInJson['candidates']) {
        candidateList.add(Candidate.fromJson(vote));
      }

      print('Successfully loaded candidates list data');
    } else {
      print('failed to load candidates list data');
    }

    setState(() {
      isLoaded = true;
    });
  }
}
