import 'package:flutter/material.dart';

class ProofOfVote extends StatefulWidget {
  static const String routeName = 'proof-of-vote';
  @override
  _ProofOfVoteState createState() => _ProofOfVoteState();
}

class _ProofOfVoteState extends State<ProofOfVote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 100.0,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 3 / 5,
                  child: TextField(),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.search_outlined),
                  label: Text('Search'),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => _proofOfVoteBlock(
                blockHash: 'ashfgasyhfkgvyhfvkwebvfhqlsgfyugyit36r23t7r83t27',
                voterHash: 'ahsvckahgsvcqywlgf7328otr732gfyvc32o78',
                votedTo: 'Me'),
          )),
        ],
      ),
    );
  }

  Widget _proofOfVoteBlock(
          {@required String blockHash,
          @required String voterHash,
          @required String votedTo}) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
        height: 70.0,
        width: double.infinity,
        color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              child: Container(child: Text(blockHash)),
            ),
            Flexible(
              flex: 1,
              child: Container(child: Text(votedTo)),
            ),
            Flexible(
              flex: 3,
              child: Container(child: Text(voterHash)),
            ),
          ],
        ),
      );
}
