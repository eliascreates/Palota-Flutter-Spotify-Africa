import 'package:flutter_spotify_africa_assessment/features/spotify/domain/entities/track.dart';

class Playlist {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final int totalFollowers;
  final bool collaborative;
  final List<Track> tracks;
  final String type;
  
  Playlist({
    required this.collaborative,
    required this.description,
    required this.totalFollowers,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.tracks,
    required this.type,
  });
}
