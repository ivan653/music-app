import 'package:flutter/material.dart';
import 'package:music_player/LibraryController.dart';
import 'package:music_player/data_types/playlist.dart';
import 'package:music_player/data_types/track.dart';
import 'package:music_player/wigets/musicBox.dart';
import 'package:music_player/wigets/music_container.dart';
import 'package:music_player/wigets/player_buttons.dart';
import 'package:music_player/wigets/player_controller.dart';
import 'package:provider/provider.dart';

class PlaylistsManagerPage extends StatelessWidget {
  const PlaylistsManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LibraryController>();

    Future createPlaylist() => showDialog(
      context: context,
      builder: (context) {
        String playlistTitle = '';
        return AlertDialog(
          title: Text('Create Playlist'),
          content: TextField(
            onChanged: (value) {
              playlistTitle = value;
            },
            decoration: InputDecoration(hintText: 'Playlist Title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (playlistTitle.isNotEmpty) {
                  // Create a new playlist and add it to the controller
                  final newPlaylist = Playlist(
                    id: DateTime.now().toString(),
                    title: playlistTitle,
                  );
                  context.read<LibraryController>().playlists.add(newPlaylist);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
    //controller.playlists.
    return Scaffold(
      appBar: AppBar(title: const Text('Playlist')),
      body: Column(
        children: [
          IconButton(
            onPressed: () async {
              createPlaylist();
            },
            icon: Icon(Icons.add),
          ),

          ListView(
            children: controller.playlists
                .map(
                  (playlist) => ListTile(
                    title: Text(playlist.title),
                    onTap: () {
                      // Handle playlist selection
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
