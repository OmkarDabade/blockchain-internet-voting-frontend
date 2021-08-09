import 'dart:io';

// const String hostUrl = 'ivote-mickel.herokuapp.com';
// const int hostUrlPort = 5123;

const double version = 0.1;

//'http://127.0.0.1:5132/'
// const String baseAPIUrl = 'http://127.0.0.1:5000/';
const String baseAPIUrl = 'https://ivote-mickel.herokuapp.com/';

// API's
const String apiAddCandidate = 'addCandidate';
// const String apiAddVoter = 'addVoter';
const String apiCastVote = 'castVote';
const String apiChain = 'chain';
// const String apiConsensus = 'consensus';
const String apiForgotPassword = 'forgotPassword';
const String apiGetCandidates = 'getCandidates';
// const String apiGetDataStats = 'getDataStats';
const String apiLogin = 'login';
const String apiSearch = 'search';
const String apiSignup = 'signup';

const Map<String, String> postHeaders = {
  HttpHeaders.contentTypeHeader: "application/json"
};

Map<String, String> postHeadersWithJWT(String token) {
  return {"Content-Type": "application/json", 'Authorization': 'Bearer $token'};
}
