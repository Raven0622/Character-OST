import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(const MyApp());

class ImageButton extends StatefulWidget {
  final String imageName;
  final String soundFile;

  const ImageButton({required this.imageName, required this.soundFile, Key? key}) : super(key: key);

  @override
  _ImageButtonState createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;

  void _toggleSound() async {
    if (_isPlaying) {
      await _player.stop();
      setState(() {
        _isPlaying = false;
      });
    } else {
      await _player.play(AssetSource(widget.soundFile));
      setState(() {
        _isPlaying = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: _toggleSound,
        child: Image.asset('assets/${widget.imageName}.png', fit: BoxFit.cover),
      ),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Character OST',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.black,
        body: const SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display package name and description
                const Text(
                  'Audio Player Package',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'This demo shows how to play and stop audio files using the Audioplayers package.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30), // Add space before the buttons
                const ImageButton(imageName: 'xiao', soundFile: 'XO.wav'),
                const ImageButton(imageName: 'nina', soundFile: 'NO.wav'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}