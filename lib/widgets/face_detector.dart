import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'Eyes.dart';
import 'camera_view.dart';
import 'package:temp_pheme/constants.dart';
// import 'painters/face_detector_painter.dart';

class FaceDetectorView extends StatefulWidget {
  @override
  State<FaceDetectorView> createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  double faceLeft = 150.0;
  double faceTop = 300.0;
  double leftEyeTop = 435.0; double leftEyeLeft = 145.0;
  double rightEyeTop = 435.0; double rightEyeLeft = 220.0;
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Stack(
      children : [
        Opacity(
          opacity: 0.009,
          // opacity: 0.2,
          child: CameraView(
            title: 'Face Detector',
            customPaint: _customPaint,
            text: _text,
            onImage: (inputImage) {
              processImage(inputImage);
            },
            initialDirection: CameraLensDirection.front,
          ),
        ),
        Eyes(),
        // Container(
        //
        //     child: Center(child: Image.asset(width: 200,'assets/images/face.png'))
        // ), //faace
        // Container(
        //
        //     margin: EdgeInsets.only(top:leftEyeTop,left:leftEyeLeft),
        //     width:16,
        //     child: Image.asset('assets/images/left_eye.png')
        // ), //left eye
        // Container(
        //     margin: EdgeInsets.only(top:rightEyeTop,left:rightEyeLeft),
        //     width:16,
        //     child: Image.asset('assets/images/right_eye.png')
        // ), //right eye

      ],

    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final faces = await _faceDetector.processImage(inputImage);
    if (faces == null) {
      setState(() {
        leftMargin = 5.0;
        rightMargin = 5.0;
        topMargin = 10.0;
        bottomMargin = 5.0;
      });
    }
    for (var face in faces){
      final Rect boundingBox = face.boundingBox;
      final double left = boundingBox.left;
      final double top = boundingBox.top;
      setState(() {
        // double leftMargin = 5.0;
        // double rightMargin = 5.0;
        // double topMargin = 10.0;
        // double bottomMargin = 5.0;
        if(left < 70){ //look right
          // print('leftie');
          leftMargin = 20;
          rightMargin = 1;
        } else if(left > 70  && left < 219) { //centralize eyes horizontally
          // print('center');
          leftMargin = 5.0;
          rightMargin = 5.0;
        }else if (left > 160) { //look right
          // print('rightie');
          leftMargin = 1;
          rightMargin = 20;
        }
        if(top < 270){ //look down
          // print('downie');
          bottomMargin = 20.0;
          topMargin = 1.0;

        } else if(top < 480 && top > 270){ //centralize eyes vertically
          topMargin = 10.0;
          bottomMargin = 5.0;
        } else if(top > 480){ //look up
          // print('toppie');
          topMargin = 20.0;
          bottomMargin = 1;

        }

        faceLeft = left;
        faceTop = top ;
      }

        // double leftEyeTop = 435.0; double leftEyeLeft = 145.0;
        // double rightEyeTop = 435.0; double rightEyeLeft = 220.0;


      );
      // Use the coordinates as required


    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
//far left is 360
//far right is 1
//center is 170
//1............170................360
//left.........center..............right

//far top is 1
//far bottom is 700
//vertical center is 375
//1  top
//.
//.
//.
//375 center
//.
//.
//.
//700 bottom


