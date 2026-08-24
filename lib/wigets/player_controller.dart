import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/data_types/track.dart';

class PlayerController extends ChangeNotifier {
  final _player = AudioPlayer();
  List<Track> _queue = [];
  int _currentIndex = -1;

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  bool get isPlaying => _player.playing;
  AudioPlayer get player => _player;
  Duration trackPosition = Duration();

  bool _isInitialized = false;
  late StreamSubscription<Duration> _positionSubscription;

  PlayerController() {
    _positionSubscription = _player.positionStream.listen((position) {
      trackPosition = position;
      notifyListeners();
    });
  }

  Track? get currentTrack => _currentIndex >= 0 && _currentIndex < _queue.length
      ? _queue[_currentIndex]
      : null;

  void setQueue(List<Track> tracks, {int startIndex = 0}) {
    _queue = tracks;
    _currentIndex = startIndex;
    //playTrack(_queue[_currentIndex]);
  }

  Future<void> playNext() async {
    if (_currentIndex < _queue.length - 1) {
      _currentIndex++;
      await playTrack(_queue[_currentIndex]);
    }
  }

  Future<void> playPrevious() async {
    if (_currentIndex > 0) {
      _currentIndex--;
      await playTrack(_queue[_currentIndex]);
    }
  }

  Future<void> playTrack(Track track) async {
    _currentIndex = _queue.indexOf(track);
    await _player.setUrl(track.audioUrl);
    await _player.play();
    _isInitialized = true;
    notifyListeners(); // tells listening widgets to rebuild
  }

  Future<void> togglePlayPause() async {
    if (!_isInitialized && currentTrack != null) {
      await _player.setUrl(currentTrack!.audioUrl);
      _isInitialized = true;
    }
    _player.playing ? await _player.pause() : await _player.play();
    notifyListeners();
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _player.dispose();
    super.dispose();
  }

  bool _showPanel = false;
  bool get showPanel => _showPanel;

  void togglePanel() {
    _showPanel = !_showPanel;
    notifyListeners();
  }
}
