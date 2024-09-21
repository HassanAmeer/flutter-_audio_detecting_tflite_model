import 'package:flutter/material.dart';
import 'package:flutter_tensorflow_audio/common/ui/constants/colors.dart';
import 'package:flutter_tensorflow_audio/common/ui/constants/texts.dart';
import 'package:flutter_tensorflow_audio/features/audio_mic/presentation/widgets/inference_time_widget.dart';
import 'package:flutter_tensorflow_audio/features/audio_mic/presentation/widgets/label_list_widget.dart';
import 'dart:async';
import 'dart:developer';
import 'package:tflite_audio/tflite_audio.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class AudioMicPage extends StatefulWidget {
  const AudioMicPage({Key? key}) : super(key: key);

  @override
  _AudioMicPageState createState() => _AudioMicPageState();
}

class _AudioMicPageState extends State<AudioMicPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final isRecording = ValueNotifier<bool>(false);
  Stream<Map<dynamic, dynamic>>? result;

  final String model = 'assets/audio/soundclassifier_with_metadata.tflite';
  final String label = 'assets/audio/labels.txt';

  @override
  void initState() {
    super.initState();
    TfliteAudio.loadModel(
      inputType: 'rawAudio',
      outputRawScores: false,
      model: model,
      label: label,
      isAsset: true,
      numThreads: 1,
    );
  }

  void getResult() {
    result = TfliteAudio.startAudioRecognition(
      sampleRate: 44100,
      bufferSize: 22016,
      numOfInferences: 5,
      detectionThreshold: 0.3,
     // averageWindowDuration: 3000,
      //minimumTimeBetweenSamples: 50,
     // suppressionTime: 2000,
    );

    // Os eventos disponiveis são:
    // event["recognitionResult"], event["hasPermission"], event["inferenceTime"]

    result
        ?.listen((event) =>
            log("Recognition Result: " + event["recognitionResult"].toString()))
        .onDone(() => isRecording.value = false);
  }

  //fetches the labels from the text file in assets
  Future<List<String>> fetchLabelList() async {
    List<String> _labelList = [];
    await rootBundle.loadString(label).then((q) {
      for (String i in const LineSplitter().convert(q)) {
        _labelList.add(i);
      }
    });
    return _labelList;
  }

  String showResult(AsyncSnapshot snapshot, String key) =>
      snapshot.hasData ? snapshot.data[key].toString() : 'null ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(UiText.audioRecognize),
          backgroundColor: PalletColors.primaryColor,
        ),
        body: StreamBuilder<Map<dynamic, dynamic>>(
            stream: result,
            builder: (BuildContext context,
                AsyncSnapshot<Map<dynamic, dynamic>> inferenceSnapshot) {
              return FutureBuilder(
                  future: fetchLabelList(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<String>> labelSnapshot) {
                    switch (inferenceSnapshot.connectionState) {
                      case ConnectionState.none:
                        if (labelSnapshot.hasData) {
                          return labelListWidget(labelSnapshot.data);
                        } else {
                          return const CircularProgressIndicator();
                        }
                      case ConnectionState.waiting:
                        return Stack(children: <Widget>[
                          Align(
                              alignment: Alignment.bottomRight,
                              child: inferenceTimeWidget('Calculando..')),
                          labelListWidget(labelSnapshot.data),
                        ]);
                      //Widgets will display the final results.
                      default:
                        return Stack(children: <Widget>[
                          Align(
                              alignment: Alignment.bottomRight,
                              child: inferenceTimeWidget(showResult(
                                      inferenceSnapshot, 'inferenceTime') +
                                  'ms')),
                          labelListWidget(
                              labelSnapshot.data,
                              showResult(
                                  inferenceSnapshot, 'recognitionResult'))
                        ]);
                    }
                  });
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ValueListenableBuilder(
            valueListenable: isRecording,
            builder: (context, value, widget) {
              if (value == false) {
                return FloatingActionButton(
                  onPressed: () {
                    isRecording.value = true;
                    setState(() {
                      getResult();
                    });
                  },
                  backgroundColor: PalletColors.primaryColor,
                  child: const Icon(Icons.mic),
                );
              } else {
                return FloatingActionButton(
                  onPressed: () {
                    log('Audio Recognition Stopped');
                    //Press button again to cancel audio recognition
                    TfliteAudio.stopAudioRecognition();
                  },
                  backgroundColor: PalletColors.blackColor,
                  child: const Icon(Icons.adjust),
                );
              }
            }));
  }
}
