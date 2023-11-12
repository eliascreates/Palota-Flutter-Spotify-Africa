import 'track.dart';

class Playlist {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final int totalFollowers;
  final List<Track> tracks;

  const Playlist({
    required this.description,
    required this.totalFollowers,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.tracks,
  });
}
