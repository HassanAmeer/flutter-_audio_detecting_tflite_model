import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tensorflow_audio/common/ui/constants/colors.dart';
import 'package:flutter_tensorflow_audio/common/ui/constants/texts.dart';
import 'package:flutter_tensorflow_audio/common/ui/widgets/card_detector_widget.dart';
import 'package:flutter_tensorflow_audio/features/image_camera/presentation/widgets/camera_widget.dart';
import 'package:tflite/tflite.dart';

class ImageCameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const ImageCameraPage(this.cameras, {Key? key}) : super(key: key);

  @override
  _ImageCameraPageState createState() => _ImageCameraPageState();
}

class _ImageCameraPageState extends State<ImageCameraPage> {
  String _predOne = '';
  double _confidence = 0;
  double _index = 0;

  @override
  void initState() {
    super.initState();
    loadTFLiteModel();
  }

  loadTFLiteModel() async {
    await Tflite.loadModel(
        model: "assets/image/model_unquant.tflite",
        labels: "assets/image/labels.txt");
  }

  setRecognitions(outputs) {
    if (outputs[0]['index'] == 0) {
      _index = 0;
    } else {
      _index = 1;
    }

    _confidence = outputs[0]['confidence'];

    setState(() {
      _predOne = outputs[0]['label'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PalletColors.blackColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          UiText.imageRecognize,
        ),
        backgroundColor: PalletColors.primaryColor,
      ),
      body: Stack(
        children: [
          CameraWidget(widget.cameras, setRecognitions),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: cardDetectorWidget(
                _index,
                _confidence,
                UiText.appleObject,
                UiText.bananaObject,
              ),
            ),
          )
        ],
      ),
    );
  }
}
