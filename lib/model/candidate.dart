class Candidate {
  String candidateName, candidateId;
  int ward;
  String state, district;

  Candidate(
      {this.candidateId,
      this.candidateName,
      this.ward,
      this.state,
      this.district});

  factory Candidate.fromJson(Map<String, dynamic> jsonData) {
    return Candidate(
      candidateId: jsonData['candidateId'],
      candidateName: jsonData['candidateName'],
      state: jsonData['state'],
      district: jsonData['district'],
      ward: jsonData['ward'],
    );
  }
}
