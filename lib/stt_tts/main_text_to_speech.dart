


import 'dart:io';
import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:temp_pheme/stt_tts/play_downloaded_voice.dart';
import 'package:temp_pheme/stt_tts/record_voice.dart';
import 'package:temp_pheme/stt_tts/text_to_speech.dart';
import 'package:flutter/services.dart';
import 'package:google_speech/google_speech.dart';
// import 'package:assets_audio_player/assets_audio_player.dart';

import '../constants.dart';
import '../excel_handling/get_excel_questions_google.dart';
import '../excel_handling/write_excel_answers_google.dart';
import '../main.dart';

void get_questions_playable() async{
  print('attempting to get questions..');
  int questionIndex = 1;
  // get_google_sheet(); //this will get all questions and save them to questionList in constants file

  await Permission.storage.request();
  PermissionStatus status = await Permission.storage.request();
  await Permission.manageExternalStorage.request();

  for(String question in questionList){

    question_text_to_base64(question).then((encodedQuestion){//first send text to cloud and get audio as base 64
      decodeBase64AudioAndSaveAsMP3(encodedQuestion,questionIndex);//then decode this base 64 string to mp3 and save it
      questionIndex++;
    });
  }
  questionIndex = 1;
}
Future<int> playAudioFromAsset(String filePath, AudioPlayer audioPlayer) async {
   await audioPlayer.play(DeviceFileSource(filePath));
   return 0;
}

void askQuestion(String filePath) async{
  AudioPlayer audioPlayer = AudioPlayer();
  audioPlayer.play(DeviceFileSource(filePath));
  await Future.delayed(Duration(seconds:10));
  audioPlayer.dispose();
}

void interacty() async{
  int questionIndex = 1;

  int semaphore = 0;

  for (String question in questionList){
    String filePath = '/storage/emulated/0/Download/${questionIndex}.mp3';
    // Play the saved audio using audioplayers package

    //==============ask question=======================
    NormalEyeColor = AskingEyeColor;
    print('playing question ${questionIndex}');
    askQuestion(filePath);
//======================================================


    //=============listen to answer ===============================
    NormalEyeColor = ListeningEyeColor;
    print('recording voice for answer ${questionIndex}');
      record_voice('${questionIndex}');
      //=========================================

    //====================transcribe answer=============================
      print('transcribing answer ${questionIndex}');
      recognize('${questionIndex}');
      questionIndex++;

  }
  write_to_google_sheet();
  questionIndex = 1;
}
Future<int> recognize(String fileName) async {
  String text ='';
  final serviceAccount = ServiceAccount.fromString(
      '${(await rootBundle.loadString('assets/test_service_account.json'))}');
  final speechToText = SpeechToText.viaServiceAccount(serviceAccount);
  final config = _getConfig();
  final audio = await _getAudioContent('${fileName}');

  await speechToText.recognize(config, audio).then((value) {

      text = value.results
          .map((e) => e.alternatives.first.transcript)
          .join('\n');
      answerList.add(text);
  }).whenComplete((){
      print('transcribed');
    }
  );
  return 0;
}


Future<List<int>> _getAudioContent(String fileName) async {

  String path = '/storage/emulated/0/Download/${fileName}.wav';
  // if (!File(path).existsSync()) {
  //   print("${fileName} doesnt exist ");
  //   await _copyFileFromAssets(fileName);
  // }
  return File(path).readAsBytesSync().toList();
}

Future<void> _copyFileFromAssets(String name) async {
  var data = await rootBundle.load('assets/$name');
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path + '/$name';
  await File(path).writeAsBytes(
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}

RecognitionConfig _getConfig() => RecognitionConfig(
    encoding: AudioEncoding.LINEAR16,
    model: RecognitionModel.basic,
    enableAutomaticPunctuation: true,
    sampleRateHertz: 16000,
    languageCode: 'ar-EG'
);