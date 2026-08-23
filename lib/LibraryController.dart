import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:music_player/data_types/playlist.dart';
import 'package:music_player/data_types/track.dart';

class LibraryController extends ChangeNotifier {
  List<Track> _songs = [];
  List<Playlist> _playlists = [];
  bool _isLoading = false;

  List<Track> get songs => _songs;
  List<Playlist> get playlists => _playlists;
  bool get isLoading => _isLoading;

  get http => null;

  /*Future<void> fetchSongs() async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse('http://твій-сервер/songs'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      _songs = data.map((json) => Track.fromJson(json)).toList();
    }

    _isLoading = false;
    notifyListeners();
  }*/
}
