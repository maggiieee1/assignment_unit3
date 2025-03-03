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
      theme: ThemeData(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: LocalMusicPlayerScreen(),
    );
  }
}

class LocalMusicPlayerScreen extends StatefulWidget {
  const LocalMusicPlayerScreen({super.key});

  @override
  _LocalMusicPlayerScreenState createState() => _LocalMusicPlayerScreenState();
}

class _LocalMusicPlayerScreenState extends State<LocalMusicPlayerScreen> with WidgetsBindingObserver {
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

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
    WidgetsBinding.instance.removeObserver(this);
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.pause();
      setState(() {
        isPlaying = false;
      });
    } else if (state == AppLifecycleState.resumed) {
      _player.resume();
      setState(() {
        isPlaying = true;
      });
    }
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
              icon: Icon(
                isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                size: 80,
                color: Colors.orange,
              ),
              onPressed: _togglePlayPause,
            ),
            SizedBox(height: 20),
            Text(
              isPlaying ? 'Playing...' : 'Paused',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}