import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tensorflow_audio/common/ui/widgets/card_detector_widget.dart';

// Se o a stream bater com o resultado ira mudar o estado do card
Widget labelListWidget(List<String>? labelList, [String? result]) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: labelList!.map((labels) {
              // log('label $labels , $result');
              if (labels == result) {
                return cardDetectorWidget(
                    1,
                    1,
                    'Resultado',
                    labels.toString() == "0 Speech"
                        ? "Speech"
                        : labels.toString() == "1 Child speech, kid speaking"
                            ? "kid speaking "
                            : labels.toString() == "2 Conversation"
                                ? "Conversation 🎙️"
                                : "Desconhecido");
              } else {
                return cardDetectorWidget(
                    2,
                    1,
                    'Resultado',
                    labels.toString() == "0 Speech"
                        ? "Speech"
                        : labels.toString() == "1 Child speech, kid speaking"
                            ? "kid speaking "
                            : labels.toString() == "2 Conversation"
                                ? "Conversation 🎙️"
                                : "Desconhecido");
              }
            }).toList())),
  );
}
