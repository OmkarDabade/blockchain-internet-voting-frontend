import 'dart:io';

import 'package:ivote/model/vote.dart';

// const String hostUrl = 'ivote-mickel.herokuapp.com';
// const int hostUrlPort = 5123;

const double version = 0.2;

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

List<Vote> demoVoteChain = [
  Vote(
      blockHash:
          '!!!!!!!!!!!!!!!!!!!!!!!!!!!DeMo Bl0cK HAsH!!!!!!!!!!!!!!!!!!!!!!!!!!!',
      candidateId: 101,
      candidateName: 'Demo Candidate to Vote',
      index: 0,
      nonce: 4739,
      previousHash:
          '!!!!!!!!!!!!!!!!!!!!!!!!PreV!ou\$ DeMo Bl0cK HAsH!!!!!!!!!!!!!!!!!!!!!!!!',
      timeStamp: DateTime.now().toIso8601String(),
      voterIdHash:
          '!!!!!!!!!!!!!!!!!!!!Y0uR Un!QuE DigiTAl FingeRpRint!!!!!!!!!!!!!!!!!!!!'),
  Vote(
      blockHash:
          '!!!!!!!!!!!!!!!!!!!!!!!!!!!DeMo Bl0cK HAsH!!!!!!!!!!!!!!!!!!!!!!!!!!!',
      candidateId: 102,
      candidateName: 'Demo Candidate',
      index: 1,
      nonce: 479,
      previousHash:
          '!!!!!!!!!!!!!!!!!!!!!!!!PreV!ou\$ DeMo Bl0cK HAsH!!!!!!!!!!!!!!!!!!!!!!!!',
      timeStamp: DateTime.now().toIso8601String(),
      voterIdHash:
          '!!!!!!!!!!!!!!!!!!!!Y0uR Un!QuE DigiTAl FingeRpRint!!!!!!!!!!!!!!!!!!!!'),
  Vote(
      blockHash:
          '!!!!!!!!!!!!!!!!!!!!!!!!!!!DeMo Bl0cK HAsH!!!!!!!!!!!!!!!!!!!!!!!!!!!',
      candidateId: 103,
      candidateName: 'Funny Candidate',
      index: 2,
      nonce: 439,
      previousHash:
          '!!!!!!!!!!!!!!!!!!!!!!!!PreV!ou\$ DeMo Bl0cK HAsH!!!!!!!!!!!!!!!!!!!!!!!!',
      timeStamp: DateTime.now().toIso8601String(),
      voterIdHash:
          '!!!!!!!!!!!!!!!!!!!!Y0uR Un!QuE DigiTAl FingeRpRint!!!!!!!!!!!!!!!!!!!!'),
  Vote(
      blockHash:
          '!!!!!!!!!!!!!!!!!!!!!!!!!!!DeMo Bl0cK HAsH!!!!!!!!!!!!!!!!!!!!!!!!!!!',
      candidateId: 101,
      candidateName: 'Demo Candidate to Vote',
      index: 3,
      nonce: 47839,
      previousHash:
          '!!!!!!!!!!!!!!!!!!!!!!!!PreV!ou\$ DeMo Bl0cK HAsH!!!!!!!!!!!!!!!!!!!!!!!!',
      timeStamp: DateTime.now().toIso8601String(),
      voterIdHash:
          '!!!!!!!!!!!!!!!!!!!!Y0uR Un!QuE DigiTAl FingeRpRint!!!!!!!!!!!!!!!!!!!!'),
  Vote(
      blockHash:
          '!!!!!!!!!!!!!!!!!!!!!!!!!!!DeMo Bl0cK HAsH!!!!!!!!!!!!!!!!!!!!!!!!!!!',
      candidateId: 101,
      candidateName: 'Demo Candidate to Vote',
      index: 4,
      nonce: 476339,
      previousHash:
          '!!!!!!!!!!!!!!!!!!!!!!!!PreV!ou\$ DeMo Bl0cK HAsH!!!!!!!!!!!!!!!!!!!!!!!!',
      timeStamp: DateTime.now().toIso8601String(),
      voterIdHash:
          '!!!!!!!!!!!!!!!!!!!!Y0uR Un!QuE DigiTAl FingeRpRint!!!!!!!!!!!!!!!!!!!!'),
];
