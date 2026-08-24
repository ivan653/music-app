import 'package:flutter/material.dart';

class Track {
  String title = "title";
  int duration = 1; // in seconds
  String audioUrl;
  String logoUrl;

  Track({
    required this.title,
    required this.duration,
    required this.audioUrl,
    String? logo,
  }) : logoUrl = logo ?? 'assets/default_track_icon.png';
}
