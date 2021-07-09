String kState, kDistrict;
int kWard;
String kVoterJWTToken;
String kVoterName;
String kVoterId;

void extractVoterData(Map<String, dynamic> jsonDecodedData) {
  print('EXTRACTING DATA:');
  print(jsonDecodedData);

  kVoterId = jsonDecodedData['voter']['voterId'];
  print('Voter: $kVoterId');
  kState = jsonDecodedData['voter']['state'];
  print('State: $kState');
  kDistrict = jsonDecodedData['voter']['district'];
  print('DIST: $kDistrict');
  kWard = jsonDecodedData['voter']['ward'];
  print('Ward: $kWard');
  kVoterName = jsonDecodedData['voter']['name'];
  print('Name: $kVoterName');

  kVoterJWTToken = jsonDecodedData['token'];
  print('Token: $kVoterJWTToken');
}
