import 'package:flutter/material.dart';
import 'package:flutter_tensorflow_audio/common/ui/constants/styles.dart';
import 'package:flutter_tensorflow_audio/common/ui/constants/texts.dart';
import 'package:flutter_tensorflow_audio/features/audio_mic/presentation/pages/audio_mic_page.dart';
import 'package:flutter_tensorflow_audio/features/audio_mic/presentation/pages/sounds_mic_page.dart';
// import 'package:flutter_tensorflow_audio/features/image_camera/presentation/pages/image_camera_page.dart';
import 'package:flutter_tensorflow_audio/features/image_camera/presentation/pages/speech_to_text.dart';

import '../../../audio_mic/presentation/pages/audio2.dart';

class HomePage extends StatefulWidget {
  // final List<CameraDescription> cameras;
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.1,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .3,
              width: double.infinity,
              child: Image.asset(
                'assets/homeScreen.png',
                scale: .5,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                ElevatedButton(
                  style: AppStyle.buttonStyle,
                  onPressed: () {
                    // TODO::
                  },
                  child: const Text(
                    'Reconhecimento Simultâneo',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: AppStyle.buttonStyle,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Speech()),
                  ),
                  child: const Text(
                    UiText.audioRecognize,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: AppStyle.buttonStyle,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AudioMicPage()),
                  ),
                  child: const Text(
                    "Transcrição de Fala",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: AppStyle.buttonStyle,
                  onPressed: () {
                    // TODO::
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Audio2Page()));
                  },
                  child: const Text(
                    "Configurações",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
