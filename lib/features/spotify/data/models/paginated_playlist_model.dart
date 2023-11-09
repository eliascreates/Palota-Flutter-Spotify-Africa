import 'package:flutter_spotify_africa_assessment/features/spotify/data/models/models.dart';

import '../../domain/domain.dart';

class PaginatedPlaylistModel extends PaginatedPlaylist {
  final List<PlaylistModel> playlistModels;

  PaginatedPlaylistModel({
    required super.offset,
    required super.limit,
    required super.total,
    required this.playlistModels,
  }) : super(playlists: playlistModels);

  factory PaginatedPlaylistModel.fromMap(Map<String, dynamic> map) {
    return PaginatedPlaylistModel(
      offset: map['offset'] as int,
      limit: map['limit'] as int,
      total: map['total'] as int,
      playlistModels: List<PlaylistModel>.from(
        (map['playlists'] as List<dynamic>).map<PlaylistModel>(
          (playlist) => PlaylistModel.fromMap(playlist as Map<String, dynamic>),
        ),
      ),
    );
  }
}
