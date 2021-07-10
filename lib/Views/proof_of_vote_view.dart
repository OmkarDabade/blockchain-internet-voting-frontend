import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ivote/App/constants.dart';
import 'package:ivote/App/routes.dart';
import 'package:http/http.dart' as http;
import 'package:ivote/model/vote.dart';

class ProofOfVoteView extends StatefulWidget {
  @override
  _ProofOfVoteState createState() => _ProofOfVoteState();
}

class _ProofOfVoteState extends State<ProofOfVoteView> {
  List<Vote> chain = [];
  Map<String, dynamic> chainInJson;
  bool isLoaded;

  @override
  void initState() {
    isLoaded = false;
    getChain();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 46,
        shadowColor: Colors.blueAccent,
        title: Text("Welcome"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout_outlined),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushNamed(context, Routes.voterLoginView);
            },
          ),
        ],
      ),
      key: Key(Routes.proofOfVoteView),
      body: isLoaded
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 70.0,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 3 / 5,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText:
                                  'Enter your private key to check your vote submission'),
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlue,
                          onPrimary: Colors.white,
                          shadowColor: Colors.black,
                          elevation: 10,
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.search_sharp),
                        label: Text('Search', style: TextStyle(fontSize: 18.0)),
                      )
                    ],
                  ),
                ),
                _proofOfVoteBlock(
                    blockNo: 'Block#',
                    voterHash: 'Voter',
                    blockHash: 'Tx Block Hash',
                    votedTo: 'Vote to',
                    timestamp: 'Time'),
                const SizedBox(height: 10.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: chain.length,
                    itemBuilder: (context, index) => _proofOfVoteBlock(
                      blockNo: chain[index].index.toString(),
                      blockHash: chain[index].blockHash,
                      voterHash: chain[index].voterIdHash,
                      votedTo: chain[index].candidateName,
                      timestamp: chain[index].timeStamp,
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
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

  Widget _proofOfVoteBlock(
          {@required String blockHash,
          @required String voterHash,
          @required String votedTo,
          @required String blockNo,
          @required String timestamp}) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 2.0),
        padding: EdgeInsets.all(15.0),
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.grey[400],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(child: Text(blockNo)),
            ),
            Expanded(
              flex: 4,
              child: Container(child: Text(voterHash)),
            ),
            Expanded(
              flex: 2,
              child: Container(child: Text(votedTo)),
            ),
            Expanded(
              flex: 3,
              child: Container(child: Text(timestamp)),
            ),
            Expanded(
              flex: 7,
              child: Container(child: Text(blockHash)),
            ),
          ],
        ),
      );

  void getChain() async {
    chain = [];

    http.Response response = await http.get(
      Uri(
        host: hostUrl,
        port: hostUrlPort,
        path: apiChain,
        // scheme: 'http',
      ),
    );

    print('RESPONSE: ');
    chainInJson = jsonDecode(response.body);

    for (Map<String, dynamic> vote in chainInJson['chain']) {
      chain.add(Vote.fromJson(vote));
    }

    print('Successfully loaded chain data');
    setState(() {
      isLoaded = true;
    });
  }
}
