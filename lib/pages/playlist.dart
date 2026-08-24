import 'package:flutter/material.dart';
import 'package:music_player/data_types/playlist.dart';
import 'package:music_player/data_types/track.dart';
import 'package:music_player/wigets/musicBox.dart';
import 'package:music_player/wigets/music_container.dart';
import 'package:music_player/wigets/player_buttons.dart';
import 'package:music_player/wigets/player_controller.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class PlaylistPage extends StatelessWidget {
  final Playlist _playlist;
  Playlist get playlist => _playlist;

  const PlaylistPage({super.key, required this._playlist});

  /*static final track = Track(
    title: 'Пляшка фраголіно',
    duration: 180,
    audioUrl:
        'https://github.com/rafaelreis-hotmart/Audio-Sample-files/raw/master/sample.mp3',
  );*/
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PlayerController>();

    return Scaffold(
      appBar: AppBar(title: Text(_playlist.title)),
      body: Column(
        children: [
          IconButton(
            onPressed: () async {
              PlatformFile? file = await FilePicker.pickFile();
              if (file != null) {
                print(file.name);
                print(await file.length());
              } else {
                // User canceled the picker
              }
            },
            icon: Icon(Icons.add),
          ),
          Expanded(
            child: ListView(
              children: [
                ..._playlist.tracks.map(
                  (track) => MusicContainer(track: track),
                ),
              ],
            ),
          ),

          if (controller.showPanel)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Consumer<PlayerController>(
                      builder: (context, controfller, child) {
                        return Container(
                          width: double.infinity,
                          height: 600,
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Icon(Icons.music_note, size: 48),
                              Text(
                                controller.currentTrack?.title ?? '',
                                style: TextStyle(fontSize: 26),
                              ),
                              PlayerButtons(),
                              Slider(
                                min: 0,
                                max:
                                    controller.currentTrack?.duration
                                        .toDouble() ??
                                    1,
                                value: controller.trackPosition.inSeconds
                                    .toDouble(),
                                onChanged: (value) {
                                  controller.player.seek(
                                    Duration(seconds: value.toInt()),
                                  );
                                },
                              ),
                              // Add your bottom sheet content here
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              child: Container(
                color: Theme.of(context).colorScheme.primary,
                width: double.infinity,
                //height: 150,
                padding: const EdgeInsets.all(16.0),
                child: controller.currentTrack == null
                    ? const SizedBox.shrink()
                    : MusicBox(track: controller.currentTrack!),
              ),
            ),
        ],
      ),
    );
  }
}
