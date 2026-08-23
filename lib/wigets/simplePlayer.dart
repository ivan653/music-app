import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SimplePlayer extends StatefulWidget {
  final String audioUrl;
  const SimplePlayer({super.key, required this.audioUrl});

  @override
  State<SimplePlayer> createState() => _SimplePlayerState();
}

class _SimplePlayerState extends State<SimplePlayer> {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadAndPlay();
  }

  Future<void> _loadAndPlay() async {
    try {
      await _player.setUrl(widget.audioUrl);
      await _player.play();
    } catch (e) {
      debugPrint('Помилка завантаження аудіо: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: _player.playerStateStream,
      builder: (context, snapshot) {
        final playing = snapshot.data?.playing ?? false;
        return IconButton(
          icon: Icon(playing ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            playing ? _player.pause() : _player.play();
          },
        );
      },
    );
  }
}
