import 'package:flutter/material.dart';
import 'package:flutter_tensorflow_audio/common/ui/constants/colors.dart';

//Tempo de inferencia
//Em quantos segundos o audio ta sendo cortado para verificar seu tipo

Widget inferenceTimeWidget(String result) {
  return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(result,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: PalletColors.blackColor,
          )));
}