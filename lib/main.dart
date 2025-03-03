import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LocalMusicPlayerScreen(),
    );
  }
}

class LocalMusicPlayerScreen extends StatefulWidget {
  const LocalMusicPlayerScreen({super.key});

  @override
  _LocalMusicPlayerScreenState createState() => _LocalMusicPlayerScreenState();
}

class _LocalMusicPlayerScreenState extends State<LocalMusicPlayerScreen> {
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;

  void _togglePlayPause() async {
    if (isPlaying) {
      await _player.pause();
    } else {
      await _player.play(AssetSource('audio/Paramore - The Only Exception.mp3'));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Music Player')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled, size: 80),
              onPressed: _togglePlayPause,
            ),
            SizedBox(height: 20),
            Text(
              isPlaying ? 'Playing...' : 'Paused',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
