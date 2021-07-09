String kAdminJWTToken;
String kAdminName;
String kAdminId;

void extractAdminData(Map<String, dynamic> jsonDecodedData) {
  print('EXTRACTING DATA:');
  print(jsonDecodedData);

  kAdminId = jsonDecodedData['loginId'];
  print('Voter: $kAdminId');

  kAdminName = jsonDecodedData['name'];
  print('Name: $kAdminName');

  kAdminJWTToken = jsonDecodedData['token'];
  print('Token: $kAdminJWTToken');
}
