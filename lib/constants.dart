

//to move eyeballs
import 'dart:ui';

import 'package:flutter/material.dart';

double leftMargin = 5.0;
double rightMargin = 5.0;
double topMargin = 10.0;
double bottomMargin = 5.0;



//to store questions retrieved from google sheets
List<String> questionList = [];
List<String> answerList = [];

Gradient NormalEyeColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomLeft,
  colors: [
    Colors.deepPurple,
    Colors.teal,
  ],
);

Gradient  ListeningEyeColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomLeft,
  colors: [
    Colors.green,
    Colors.greenAccent,
  ],
);

Gradient AskingEyeColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomLeft,
  colors: [
    Colors.deepPurple,
    Colors.teal,
  ],
);