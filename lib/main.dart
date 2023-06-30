//@dart=2.9
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:temp_pheme/constants.dart';
import 'package:temp_pheme/excel_handling/get_excel_questions_google.dart';
import 'package:temp_pheme/stt_tts/main_text_to_speech.dart';
import 'package:temp_pheme/stt_tts/record_voice.dart';
import 'package:temp_pheme/widgets/Eyes.dart';
import 'package:temp_pheme/widgets/face_detector.dart';

import 'excel_handling/write_excel_answers_google.dart';

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();


}

class _MyAppState extends State<MyApp> {

  @override

  void interact() async{
    await get_google_sheet(); //get questions from google sheet as text
    await get_questions_playable(); //get questions from google cloud as audio
    int questionIndex = 1;
    for (String question in questionList){
      String filePath = '/storage/emulated/0/Download/${questionIndex}.mp3';
      //==============ask question=======================
      setState(() {
        NormalEyeColor = AskingEyeColor;
      });
      print('playing question ${questionIndex}');
      await askQuestion(filePath);
//======================================================


      //=============listen to answer ===============================
      setState(() {
        NormalEyeColor = ListeningEyeColor;
      });
      print('recording voice for answer ${questionIndex}');
      await record_voice('${questionIndex}');
      //=========================================

      //====================transcribe answer=============================
      print('transcribing answer ${questionIndex}');
      await recognize('${questionIndex}');
      questionIndex++;
    }
    setState(() {
      NormalEyeColor = AskingEyeColor;
    });
    write_to_google_sheet();
    questionIndex = 1;
  }
  void initState() {

    interact();
  }
  void get_started(){
    interact();
  }
  void display_questions(){
    for(String question in questionList){
      print(question);
    }
  }
  void display_answers(){
    for (String answer in answerList){
      print(answer);
    }
  }

//get_questions_playable
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            FloatingActionButton(
              child: Text('answers'),
                onPressed: display_answers,
            ),
            FloatingActionButton(
              child: Text('start'),
                onPressed: get_started,
            ),
            FloatingActionButton(
              child: Text('questions'),
              onPressed: display_questions,
            ),
            FloatingActionButton(
              child: Text('eye'),
                onPressed: (){
                print('changing eye color');
                NormalEyeColor == ListeningEyeColor ? AskingEyeColor : ListeningEyeColor;
                if(NormalEyeColor == AskingEyeColor){
                  NormalEyeColor = ListeningEyeColor;
                }else {
                  NormalEyeColor = AskingEyeColor;
                }
                // setState(() {
                //   // NormalEyeColor = ListeningEyeColor;
                // });
                }
                )
          ],
        ),
        backgroundColor: Colors.black,
        body: FaceDetectorView(),
        // body: FaceDetectorView(),
      ),
    );
  }
}
//go to app settings and please grant it all the permissions it requests </3
