import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tensorflow_audio/features/home/presentation/pages/home_page.dart';

class InputScreen extends StatefulWidget {
  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your logo here
            Image.asset('assets/homeScreen.png'),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Welcome to Speech Transcription App',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            // const SizedBox(height: 30),
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigate to the transcription screen or start the transcription
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const HomePage([])),
            //     );
            //   },
            //   child: const Text('Start Transcription'),
            // ),
          ],
        ),
      ),
    );
  }
}
