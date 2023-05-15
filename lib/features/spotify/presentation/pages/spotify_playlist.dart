import 'package:flutter/material.dart';

//TODO: complete this page - you may choose to change it to a stateful widget if necessary
class SpotifyPlaylist extends StatelessWidget {
  final String playlistId;

  const SpotifyPlaylist({Key? key, required this.playlistId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Text('Playlist ID: $playlistId'),
      ),
    );
  }
}
