

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:temp_pheme/constants.dart';
class Eyes extends StatefulWidget {
  const Eyes({
    Key? key,
  }) : super(key: key);

  @override
  State<Eyes> createState() => _Eyes();
}
class _Eyes extends State<Eyes> {

  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
    ),
  );

  double _containerSize = 100.0;
  bool _isExpanded = false;

  late Timer _timer;
  late Timer _blinky;
  int _TotalTimerDuration = 5;
  int _blinkDuration = 1;// Animation duration in seconds

  //check the bottom for directions on how to move eyes to all directions

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: _TotalTimerDuration), (_) {
      _blinkTimerr();
    });

  }
  void _blinkTimerr(){
    _blinky = Timer(Duration(seconds: _blinkDuration), () {
      _toggleContainerSize();
    });
  }

  void _toggleContainerSize() {
    setState(() {
      _isExpanded = !_isExpanded;
      _containerSize = _isExpanded ? 10.0 : 80.0;
    });
    if(_isExpanded) {
      _blinkTimerr();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _blinky?.cancel();
    super.dispose();
  }


  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.elliptical(100, _containerSize)),
                color: Colors.white,
              ),

              duration: Duration(seconds: 1),
              width: 100,
              height: _containerSize,
              curve: Curves.easeInOut,
              child: Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.only(left:leftMargin,top:topMargin,right:rightMargin,bottom:bottomMargin),

                decoration: BoxDecoration(
                    gradient: NormalEyeColor,
                    shape: BoxShape.circle
                ),
              ),

            ),
            SizedBox(width:100),
            AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.elliptical(100, _containerSize)),
                color: Colors.white,
              ),

              duration: Duration(seconds: 1),
              width: 100,
              height: _containerSize,
              curve: Curves.easeInOut,
              child: Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.only(left:leftMargin,top:topMargin,right:rightMargin,bottom:bottomMargin),

                decoration: BoxDecoration(
                    gradient: NormalEyeColor,
                    shape: BoxShape.circle
                ),
              ),

            ),

        ]
          ),



        ),
      );

  }

}


//to move eye to left, increase marginLeft and decrease marginRight same goes for all directions
//increase oppositte direction margin and decrease same direction margin