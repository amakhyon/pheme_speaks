// Import package
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';



Future<int> record_voice(String recordedFileName) async{
  final record = Record();

// Check and request permission
  if (await record.hasPermission()) {
    //filePath
    String filePath = '/storage/emulated/0/Download/${recordedFileName}.wav';
    // String directoryPath = directory.path;
    // String filepath = '/test.wav';
    // final directory = await getApplicationDocumentsDirectory();
    // final filePath = directory.path.toString() + '/test.wav';
// Start recording
    await record.start(
      device: null ,
      numChannels: 1,
      path: filePath,
      encoder: AudioEncoder.pcm16bit, // by default
      bitRate: 16000, // by default
      samplingRate: 16000, // by default

    );
  }
  await Future.delayed(Duration(seconds: 7)).then((result) async{
    await record.stop();
  });


// Get the state of the recorder
  bool isRecording = await record.isRecording();

// Stop recording
  return 0;
}
