import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ivote/App/constants.dart';
import 'package:ivote/App/routes.dart';
import 'package:http/http.dart' as http;
import 'package:ivote/model/vote.dart';

class ProofOfVoteView extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  _ProofOfVoteState createState() => _ProofOfVoteState();
}

class _ProofOfVoteState extends State<ProofOfVoteView> {
  List<Vote> chain = [], tempChain;
  Map<String, dynamic> chainInJson;
  bool isLoaded, searchResults;
  final List<String> queries = ['blockNo', 'blockHash', 'voterIdHash'];
  String selectedQuery = 'blockNo', messageToDisplay;
  dynamic searchValue;

  TextEditingController textEditingController = TextEditingController();

  final Map<String, String> searchBoxHints = {
    'blockNo': 'Enter the INDEX of block where your vote resides',
    'blockHash': 'Enter the HASH of block where your vote resides',
    'voterIdHash': 'Enter the YOUT VOTER HASH of block where your vote resides',
  };

  @override
  void initState() {
    getChain();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 46,
        shadowColor: Colors.blueAccent,
        leading: Offstage(),
        title: TextButton(
          child: Text("Proof of Vote",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              )),
          onPressed: () {
            getChain();
          },
        ),
        //   actions: <Widget>[
        //     IconButton(
        //       icon: Icon(Icons.power_settings_new),
        //       tooltip: 'Logout',
        //       onPressed: () {
        //         Navigator.pushNamed(context, Routes.voterLoginView);
        //       },
        //     ),
        //     Text('\n Logout   '),
        //   ],
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
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Container(
                        height: 20.0,
                        width: 100.0,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            // decoration: InputDecoration(
                            //   labelStyle: Theme.of(context)
                            //       .primaryTextTheme
                            //       .caption
                            //       .copyWith(color: Colors.black),
                            //   border: const OutlineInputBorder(),
                            // ),
                            isExpanded: true,

                            items: queries.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedQuery = value;
                              });
                            },
                            value: selectedQuery,
                          ),
                        ),
                      ),
                      Form(
                        key: widget.formKey,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 3 / 5,
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Please enter Candidate Id';
                              if (selectedQuery == 'blockNo' &&
                                  int.tryParse(value) == null)
                                return "Please Enter numeric data";

                              return null;
                            },
                            onSaved: (value) {
                              if (value != null || value.isNotEmpty) {
                                if (selectedQuery == 'blockNo')
                                  searchValue = int.tryParse(value);
                                else
                                  searchValue = value;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: searchBoxHints[selectedQuery]),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 35.0,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlue,
                            onPrimary: Colors.white,
                            shadowColor: Colors.black,
                            elevation: 5,
                          ),
                          onPressed: () {
                            if (widget.formKey.currentState.validate()) {
                              widget.formKey.currentState.save();
                              searchProofOfVote();
                            }
                          },
                          icon: Icon(Icons.search_sharp),
                          label:
                              Text('Search', style: TextStyle(fontSize: 18.0)),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Expanded(
                  child: chain.isNotEmpty
                      ? SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            columnSpacing: 35.0,
                            columns: [
                              DataColumn(
                                  label: Text('Block No'), numeric: true),
                              DataColumn(label: Text('Voter')),
                              DataColumn(label: Text('Block Tx Hash')),
                              DataColumn(label: Text('Candidate Name')),
                              DataColumn(label: Text('Time')),
                            ],
                            rows: [
                              for (Vote vote in chain)
                                DataRow(cells: [
                                  DataCell(Text(vote.index.toString())),
                                  DataCell(Text(vote.voterIdHash)),
                                  DataCell(Text(vote.blockHash)),
                                  DataCell(Text(vote.candidateName)),
                                  DataCell(Text(vote.timeStamp)),
                                ])
                            ],
                          ),
                        )
                      : Center(
                          child: Text(messageToDisplay),
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

  void getChain() async {
    setState(() {
      isLoaded = false;
    });

    chain = [];
    chainInJson = {};

    try {
      http.Response response = await http.get(
        Uri.parse(baseAPIUrl + apiChain),
        // Uri(
        //   host: hostUrl,
        //   port: hostUrlPort,
        //   path: apiChain,
        //   // scheme: 'http',
        // ),
      );

      print('RESPONSE: ${response.body}');
      chainInJson = jsonDecode(response.body);

      if (chainInJson.isNotEmpty && chainInJson['result']) {
        for (Map<String, dynamic> vote in chainInJson['chain']) {
          chain.add(Vote.fromJson(vote));
        }
        print('Successfully loaded chain data');
      }
    } catch (error) {
      messageToDisplay =
          'Connection Error, Please check your internet connection';
      print('failed to load chain data, possibly network error');
    }

    setState(() {
      isLoaded = true;
    });
  }

  void searchProofOfVote() async {
    setState(() {
      isLoaded = false;
    });
    chain = [];
    chainInJson = {};

    try {
      http.Response response = await http.post(
        Uri.parse(baseAPIUrl + apiSearch),
        // Uri(
        //   host: hostUrl,
        //   port: hostUrlPort,
        //   path: apiSearch,
        //   // scheme: 'http',
        // ),
        headers: postHeaders,
        body: json.encode({selectedQuery: searchValue}),
      );

      // if (response.statusCode == 200) {
      print('RESPONSE OF SEARCH: ${response.body}');
      chainInJson = jsonDecode(response.body);

      if (chainInJson.isNotEmpty && chainInJson['result']) {
        chain.add(Vote.fromJson(chainInJson['vote']));

        print('Successfully loaded chain data for search');
      } else if (chainInJson.isNotEmpty) {
        messageToDisplay = chainInJson['message'];
      } else {
        messageToDisplay = 'Some error occured';
      }
    } on SocketException {
      messageToDisplay =
          'Error, Please check your internet connection and try again';
      print('failed to load chain data, network error');

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
      print('failed to load chain data');
      messageToDisplay = 'Error, Please try again';

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

    setState(() {
      isLoaded = true;
    });
  }
}
