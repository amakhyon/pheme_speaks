import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants.dart';


  decodeBase64AudioAndSaveAsMP3(String encodedQuestion, int questionIndex)  {
  // Decode Base64 audio

    List<int> audioBytes = base64Decode(encodedQuestion);
    // print('decoded base64, attempting to save question: ${questionIndex}..');
    // Save audio as MP3 file
    String filePath = '/storage/emulated/0/Download/${questionIndex}.mp3';
    File? file = File(filePath);

    file.writeAsBytesSync(audioBytes);
    filePath = '';
    file = null;
    print("saved question ${questionIndex} as audio");

    // Play the saved audio using audioplayers package
    // AudioPlayer audioPlayer = AudioPlayer();
    // await audioPlayer.play(DeviceFileSource(filePath));


}

