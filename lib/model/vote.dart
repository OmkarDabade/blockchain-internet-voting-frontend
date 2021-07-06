class Vote {
  String candidateName, voterIdHash, candidateId;
  int index, nonce;
  DateTime timeStamp;
  String previousHash, blockHash;

  Vote(
      {this.candidateId,
      this.candidateName,
      this.voterIdHash,
      this.index,
      this.blockHash,
      this.nonce,
      this.previousHash,
      this.timeStamp});

  factory Vote.fromJson(Map<String, dynamic> jsonData) {
    return Vote(
      index: jsonData['block#'],
      candidateId: jsonData['candidateId'],
      candidateName: jsonData['candidateName'],
      voterIdHash: jsonData['fromVoter'],
      timeStamp: jsonData['time'],
      nonce: jsonData['nonce'],
      blockHash: jsonData['blockHash'],
      previousHash: jsonData['previousHash'],
    );
  }
}
