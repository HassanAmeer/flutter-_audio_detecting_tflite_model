import 'package:flutter/material.dart';
import 'package:flutter_tensorflow_audio/common/ui/constants/colors.dart';

Widget cardDetectorWidget(
    double index, double confidence, String firstObject, String secondObject) {
  return Card(
    color: PalletColors.primaryColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Visibility(
                      visible: firstObject == "Resultado" ? false : true,
                      child: Text(
                        firstObject,
                        style: const TextStyle(
                            color: PalletColors.whiteColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Visibility(
                      visible: firstObject == "Resultado" ? false : true,
                      child: Expanded(
                        flex: 8,
                        child: SizedBox(
                          height: 32.0,
                          child: Stack(
                            children: [
                              LinearProgressIndicator(
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    PalletColors.redColor),
                                value: confidence,
                                // value: index == 0 ? confidence : 0.0,
                                backgroundColor:
                                    PalletColors.whiteColor.withOpacity(0.2),
                                minHeight: 50.0,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${index == 0 ? (confidence * 100).toStringAsFixed(0) : 0} % ',
                                  // '${index == 0 ? (confidence * 100).toStringAsFixed(0) : 0} % ',
                                  style: const TextStyle(
                                      color: PalletColors.blackColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      secondObject,
                      style: const TextStyle(
                          color: PalletColors.whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    flex: 8,
                    child: SizedBox(
                      height: 32.0,
                      child: Stack(
                        children: [
                          LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                firstObject == "Resultado"
                                    ? PalletColors.whiteColor
                                    : PalletColors.yellowColor),
                            value: confidence,
                            // value: index == 1 ? confidence : 0.0,
                            backgroundColor:
                                PalletColors.whiteColor.withOpacity(0.2),
                            minHeight: 50.0,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '$confidence % ',
                              // '${index == 1 ? (confidence * 100).toStringAsFixed(0) : 0} % ',
                              style: const TextStyle(
                                  color: PalletColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
