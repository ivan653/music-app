import 'package:flutter/material.dart';
import 'package:music_player/data_types/track.dart';
import 'package:music_player/wigets/player_controller.dart';
import 'package:provider/provider.dart';

class MusicBox extends StatelessWidget {
  final Track track; // data comes in through the constructor

  const MusicBox({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PlayerController>();
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch, // (1) forces Row to full width
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // (2) pushes children to opposite ends
            children: [
              Row(
                // group the icon+text so they stay together on the left
                children: [
                  Icon(Icons.music_note, size: 48),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(track.title, style: TextStyle(fontSize: 26)),
                      Text(
                        '${track.duration} sec',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  controller.playTrack(track);
                },
                child: const Icon(Icons.play_arrow),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
