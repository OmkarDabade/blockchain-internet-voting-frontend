class Vote {
  String candidateName, voterIdHash;
  int index, nonce, candidateId;
  String timeStamp;
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

  @override
  String toString() {
    super.toString();

    return "Block#: ${this.index}\nCandidate Id: ${this.candidateId}\nCandidate Name: ${this.candidateName}\nVoter: ${this.voterIdHash}\nTime: ${this.timeStamp}\nNonce: ${this.nonce}\nBlock Hash: ${this.blockHash}\nPrevious Hash: ${this.previousHash}";
  }

  String stringToShowVoter() {
    return "Block#: ${this.index}\nCandidate Id: ${this.candidateId}\nCandidate Name: ${this.candidateName}\nVoter: ${this.voterIdHash}\nTime: ${this.timeStamp}\nBlock Hash: ${this.blockHash}";
  }
}
