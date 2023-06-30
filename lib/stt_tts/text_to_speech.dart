
import 'dart:convert';

import '../constants.dart';
import 'package:http/http.dart' as http;

Future<String> question_text_to_base64(String questionText) async {
  var jsonBody ={
    "audioConfig": {
      "audioEncoding": "LINEAR16",
      "pitch": 0,
      "speakingRate": 1
    },
    "input": {
      "text": "${questionText}",
    },
    "voice": {
      "languageCode": "ar-XA",
      "name": "ar-XA-Wavenet-C"
    }
  };

  //api key = AIzaSyD_VyvkOgkJtgxALuS3XqnLJL0msL0JjB8
  final url = Uri.parse('https://texttospeech.googleapis.com/v1beta1/text:synthesize?key=AIzaSyD_VyvkOgkJtgxALuS3XqnLJL0msL0JjB8');
  final headers = { 'Accept': 'applicatin/json', 'Content-Type': 'application/json'};

  final body = jsonEncode(jsonBody);

  try {
    //headers: headers,
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      // print('${responseBody['audioContent']}');
      // var base64Sound = responseBody['audioContent'];
      String encodedQuestion = responseBody['audioContent'];
      return encodedQuestion.toString();
    } else {
      return 'error ${response.statusCode}';
    }
  } catch (e) {
    print('Error: $e');
    return '$e';
  }

}

//
// void display_questions() async{
//
//   String questionToVoice = questionList[1];
//   var jsonBody ={
//     "audioConfig": {
//       "audioEncoding": "LINEAR16",
//       "pitch": 0,
//       "speakingRate": 1
//     },
//     "input": {
//       "text": "هل تناولت فطورك اليوم ؟",
//     },
//     "voice": {
//       "languageCode": "ar-XA",
//       "name": "ar-XA-Wavenet-C"
//     }
//   };
//
//
// //api key = AIzaSyD_VyvkOgkJtgxALuS3XqnLJL0msL0JjB8
//   final url = Uri.parse('https://texttospeech.googleapis.com/v1beta1/text:synthesize?key=AIzaSyD_VyvkOgkJtgxALuS3XqnLJL0msL0JjB8');
//   final headers = { 'Accept': 'applicatin/json', 'Content-Type': 'application/json'};
//
//   final body = jsonEncode(jsonBody);
//
//   try {
//     //headers: headers,
//     final response = await http.post(url, headers: headers, body: body);
//
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseBody = jsonDecode(response.body);
//       print('${responseBody['audioContent']}');
//       // var base64Sound = responseBody['audioContent'];
//       var encodedQuestion = responseBody['audioContent'];
//     } else {
//       print('Request failed with status: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
  // print('trying to print..');
  // for(String question in questionList){
  //   print(question);
  // }
//}
//===========http method and url=============================
// https://texttospeech.googleapis.com/v1beta1/text:synthesize


//======request json body==========================
// {
// "audioConfig": {
// "audioEncoding": "LINEAR16",
// "pitch": 0,
// "speakingRate": 1
// },
// "input": {
// "text": "هل تناولت فطورك اليوم؟"
// },
// "voice": {
// "languageCode": "ar-XA",
// "name": "ar-XA-Wavenet-C"
// }
// }


//===========http method and url=============================
// POST https://texttospeech.googleapis.com/v1/text:synthesize


//======request json body==========================
// {
// "input":{
// "text":"Android is a mobile operating system developed by Google, based on the Linux kernel and designed primarily for touchscreen mobile devices such as smartphones and tablets."
// },
// "voice":{
// "languageCode":"en-gb",
// "name":"en-GB-Standard-A",
// "ssmlGender":"FEMALE"
// },
// "audioConfig":{
// "audioEncoding":"MP3"
// }
// }



//===================response recieved====================
//{
//   "audioContent": "//NExAASCCIIAAhEAGAAEMW4kAYPnwwIKw/BBTpwTvB+IAxIfghUfW.."
// }

// The JSON output for the REST command contains the synthesized audio in base64-encoded format.
// Copy the contents of the audioContent field into a new file named synthesize-output-base64.txt.
// Your new file will look something like the following:



//Decode the contents of the synthesize-output-base64.txt file into a new file named synthesized-audio.mp3.
// For information on decoding base64, see Decoding Base64-Encoded Audio Content.





// POST https://texttospeech.googleapis.com/v1/text:synthesize?key=[YOUR_API_KEY] HTTP/1.1
//
// Accept: application/json
// Content-Type: application/json
//
// {
// "audioConfig": {
// "audioEncoding": "LINEAR16",
// "pitch": 0,
// "speakingRate": 1
// },
// "input": {
// "text": "صباح الخير يا صاحبي اوعي تغفلني "
// },
// "voice": {
// "languageCode": "ar-XA",
// "name": "ar-XA-Wavenet-C"
// }
// }
