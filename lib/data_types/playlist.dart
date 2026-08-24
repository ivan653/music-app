import 'package:flutter/material.dart';
import 'package:music_player/data_types/track.dart';

class Playlist {
  String id;
  String title;
  List<Track> tracks;
  Image logo;

  Playlist({
    required this.id,
    required this.title,
    required this.tracks,
    Image? logo,
  }) : logo = logo ?? Image.asset('assets/default_playlist_icon.png');
}
