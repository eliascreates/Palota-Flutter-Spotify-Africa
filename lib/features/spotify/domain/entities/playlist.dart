// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'track.dart';

class Playlist {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final int totalFollowers;
  final List<Track> tracks;

  Playlist({
    required this.description,
    required this.totalFollowers,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.tracks,
  });
}
