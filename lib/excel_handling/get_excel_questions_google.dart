import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:gsheets/gsheets.dart';
import 'package:path_provider/path_provider.dart';
import '../constants.dart';


const _spreadsheetId = '1Iw5Nup2yAOVo3kxM1g1QD1JhUTt2u7jeUnfluxmVkNA';
const _credentials = r'''
{
  "type": "service_account",
  "project_id": "pheme-388520",
  "private_key_id": "284fec0603129f88dcdfcdddfcb862b4d5f8fd71",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDZwZJBbpesFvtD\n0AU1IAfwE8EfR+bc2X/s2kuo7uwar5ayvySMXfyPJTrUQxEn737ZRhpVeDWZ8m3D\nSmTGhZ6JcM3QQqwGjHF46DEkV1nKvC7qDZtYH5E7Vf177e9377xW/zfk6ZwCPETy\nq+OPtCVvF/aeK8EhW6vUF4xIANrgULDJ4yzt4DBLwC2KzhVgXHyC5UIt8npVaV4a\nqFuMY48jIiVlbWIyKIHrr6Fp8+D4dp/VMs5kZwH/BKaCMaaC5zc7x1uoqcC8yAwF\nHJX3gFSfbYEvyAp6ntMZkKk2PCdn7K7l8z3XFFDvLjuui0DZ2lzq10hcoJZDzW48\nHgCzY4ohAgMBAAECggEACfnq0/GXpEw3Pb+ZhXoOswqMpfy60HJsgHLt1XMAwSY7\nPrwwFfg2Wm6Ht/LMpeo8gwLJsRG9TuzC55gQbuHvRfezji+HxxMHHdVxbutLk1S0\nx4dRDyP/GNtTLirT9kg29jtiGaw0OAv/0qhaWBqWPnU4GL4Dbp5PDHv5stDLNkyW\naUqPtGH0ybIhXg0Gqk3aAiRKWj5/16yTmErl29P3Xqq9ICbU607QREC4zllic7cc\nYdldbZ+zuctk56VFYa8avTG7KxolF5xqEvtAcNsFH6+NvYKFQrZGBy3ZNt+DrVrI\nN5jijDehoRyWFKG2hNFS1Y5nfhgdB7mby36vFhqriwKBgQD6KgZfliWYVfEQXnYg\nRAKOCLkciZcWU5GqaKSCxD9acSIX5wlDGrc8LBY76LoBdzDYcZxrd8wd+e0uFunB\nnSu8eV4j20dLx/+6FJMtzXX1YUkxE2nPtnSdMMR6t6q4ZSKdNfwGBb+rZlPWbDgs\nRDLtGOOWf2qtvd7mFSgMExlBnwKBgQDe1gGiwksDa5sZPFbfjcqUOkkYFRYbj+V9\n0h3slgWqQrlClC3jezjdd4215qwDeiXW/tQ4du6WpQiTOwzOF/P47BBt1IUZcqv0\nX4U8VIwOx71zRq22rNe90kyCrAk5DREhC3xtkRzl7fSuvJDMJtOW9zvdedQPKSeS\nE5C+CKEcPwKBgQCfqdrPfyEXjSKCdAeoqD+JL4AV+qr3kPbTcF4vJ9nXe4VrBAYh\nUhfIy8qVCgBNlykRu9E9tgQMzcrXM8CV1h5n+H5hHD7w2wEYXrFg9lVm+2SfceiC\nrczX1pxQRpErh0EEXcQwg9LFLlYr8H4Zop1uPghjsYcAxMJSzwX0Tuw7uQKBgHFR\nJM3OvfTEUL/5hjfy0/Si2y7K8k4b09ky85KvC7x0Z99qmRdYPyeoN0EsR4cRI5L8\nTZFVMakbzYuJeM6JMcEA0q33Z6P0Q2tm88slN4AApN+tLoN5y9A01EGTGLGRaoeC\nXskdBTQL2OTO8VdP20OnACN1Y5g+FmhbWLy6iKtjAoGBAJHQZ35nluxhwjs+SZU/\nfrwMqN/6hmLooG3tbGf+AoFuVkDqcWGAkAcw1FiP43fpALQaRTUbmNqZVM29pT7z\nZ74Bq/VqLWNAN3ojWDgwIcqDBA1EbEGY1uct/H4NLegYGHzqMs3yg2EqyzPYmyxa\n2vNrfsJ9OP/dOlcCfAqBSy0M\n-----END PRIVATE KEY-----\n",
  "client_email": "pheme-513@pheme-388520.iam.gserviceaccount.com",
  "client_id": "107270257423779843332",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/pheme-513%40pheme-388520.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

void get_google_sheet() async {

  final gsheets = GSheets(_credentials);
// fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  var sheet = ss.worksheetByTitle('Sheet1');



  await sheet?.values.column(1).then((questions){
    for(int i=1; i < questions.length ; i ++){ //in google sheets the first index is 1, in this array the first index is 0

      if(!questionList.contains(questions[i])){
          questionList.add(questions[i]);
        }
        // print("added ${i}");

    }
  });


}