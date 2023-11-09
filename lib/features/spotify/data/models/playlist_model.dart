import '../../domain/domain.dart' show Playlist;

import 'track_model.dart';

class PlaylistModel extends Playlist {
  final List<TrackModel> trackModels;

  PlaylistModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.description,
    required super.totalFollowers,
    required this.trackModels,
  }) : super(tracks: trackModels);

  factory PlaylistModel.fromMap(Map<String, dynamic> map) {
    return PlaylistModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? 'Unknown',
      imageUrl: map['imageUrl'] as String? ?? '',
      description: map['description'] as String? ?? 'No Description',
      totalFollowers: map['followers']['total'] as int? ?? 0,
      trackModels: List<TrackModel>.from(
        (map['tracks'] as List<dynamic>? ?? []).map<TrackModel>(
          (track) => TrackModel.fromMap(track as Map<String, dynamic>),
        ),
      ),
    );
  }
}
