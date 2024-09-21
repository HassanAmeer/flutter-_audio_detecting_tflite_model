import 'package:flutter/material.dart';
import 'package:flutter_tensorflow_audio/common/ui/widgets/card_detector_widget.dart';
import 'package:tflite_audio/tflite_audio.dart';
import '../../../../common/ui/constants/colors.dart';

class Audio2Page extends StatefulWidget {
  const Audio2Page({Key? key}) : super(key: key);

  @override
  _Audio2PageState createState() => _Audio2PageState();
}

class _Audio2PageState extends State<Audio2Page> {
  String _sound = "";
  bool _recording = false;
  late Stream<Map<dynamic, dynamic>> result;
  List<IndexModel> soundsName = <IndexModel>[];
  int detectionCount = 0;

  @override
  void initState() {
    super.initState();
    TfliteAudio.loadModel(
      model: 'assets/y.tflite',
      label: 'assets/y.csv',
      numThreads: 1,
      isAsset: true,
      inputType: 'rawAudio',
    );
  }

  void _startListening() {
    if (soundsName.length >= 5 && !_recording) {
      // Clear the list if there are already 5 sounds
      setState(() {
        soundsName.clear();
        detectionCount = 0; // Reset detection count
      });
    }
    if (!_recording) {
      _recorder();
    }
  }

  void _recorder() {
    if (_recording) {
      debugPrint("Already recording.");
      return;
    }

    try {
      dynamic recognition = "";
      double scoreIs = 0.0;
      double confidence = 0.0;

      setState(() => _recording = true);
      result = TfliteAudio.startAudioRecognition(
        numOfInferences: 1,
        sampleRate: 16000,
        bufferSize: 7800,
      );

      result.listen((event) {
        debugPrint("👉 event $event");
        scoreIs = double.parse(event["inferenceTime"].toString());
        recognition = event["recognitionResult"];
        confidence = scoreIs;
        // confidence = double.tryParse(event["confidence"] ?? "0.0") ?? scoreIs;
      }, onError: (error) {
        debugPrint("Error during recognition: $error");
        setState(() {
          _recording = false;
          _sound = "Error: $error";
        });
      }).onDone(() {
        setState(() {
          _recording = false;
          if (recognition.isNotEmpty) {
            String detectedSound = recognition.toString().split(",").last;

            // Check if the sound already exists in the list
            int existingIndex = soundsName.indexWhere(
              (element) => element.secondObject == detectedSound,
            );

            if (existingIndex >= 0) {
              // Sound exists, update the confidence score if the new one is higher
              soundsName[existingIndex] = IndexModel(
                index: soundsName[existingIndex].index +
                    1, // Update the sound count
                confidence: confidence < 1
                    ? double.parse(scoreIs.toString())
                    : confidence,
                secondObject: detectedSound,
              );
            } else if (soundsName.length < 5) {
              // New unique sound and list has space
              detectionCount++;
              soundsName.add(IndexModel(
                index: detectionCount.toDouble(),
                confidence: confidence,
                secondObject: detectedSound,
              ));
            } else {
              debugPrint("Maximum number of unique detections reached.");
            }

            // Sort the list by confidence in descending order
            soundsName.sort((a, b) => b.confidence.compareTo(a.confidence));
          } else {
            _sound = "No sound detected";
          }
          // Restart listening if the list has not reached the maximum number
          if (detectionCount < 5) {
            _recorder(); // Continue detection loop
          }
        });
      });
    } catch (e, st) {
      _sound = "No sound detected";
      debugPrint("💥 $e, st:$st");
    } finally {
      _sound = "No sound detected";
      debugPrint("not found");
    }
  }

  void _stop() {
    TfliteAudio.stopAudioRecognition();
    setState(() => _recording = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const Text(
          "Voice Detector",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: PalletColors.primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _recording ? _stop : _startListening,
        backgroundColor:
            _recording ? Colors.blueGrey : PalletColors.primaryColor,
        child: Icon(
          _recording ? Icons.stop : Icons.mic,
          size: 30,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ListView.builder(
              itemCount: soundsName.length,
              shrinkWrap: true,
              controller: ScrollController(),
              itemBuilder: (BuildContext context, int index) {
                return cardDetectorWidget(
                  soundsName[index].index,
                  soundsName[index].confidence,
                  "Resultado",
                  soundsName[index].secondObject,
                );
              },
            ),
            Container(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Press Button To Check Sound Type",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IndexModel {
  final double index;
  final double confidence;
  final String firstObject;
  final String secondObject;
  IndexModel({
    required this.index,
    required this.confidence,
    this.firstObject = "Resultado",
    this.secondObject = "",
  });
}
