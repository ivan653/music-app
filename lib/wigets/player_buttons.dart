import 'package:flutter/material.dart';
import 'package:music_player/wigets/player_controller.dart';
import 'package:provider/provider.dart';

class PlayerButtons extends StatelessWidget {
  const PlayerButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PlayerController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous),
          onPressed: () {
            // Implement previous track functionality
          },
        ),
        IconButton(
          //icon: Icon(Icons.play_arrow),
          icon: Icon(controller.isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            controller.togglePlayPause();
          },
        ),
        IconButton(
          icon: const Icon(Icons.skip_next),
          onPressed: () {
            // Implement next track functionality
          },
        ),
      ],
    );
  }
}
