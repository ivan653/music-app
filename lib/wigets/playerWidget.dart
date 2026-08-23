import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerWidget extends StatefulWidget {
  final String audioUrl;
  const PlayerWidget({super.key, required this.audioUrl});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  final _player = AudioPlayer(); // created once

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // Loads the source without playing yet.
    // setUrl for network streams; setFilePath for local files; setAsset for bundled assets.
    await _player.setUrl(widget.audioUrl);
  }

  @override
  void dispose() {
    _player.dispose(); // releases native resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_player.playing ? Icons.pause : Icons.play_arrow),
      onPressed: () {
        _player.playing ? _player.pause() : _player.play();
      },
    );
  }
}
