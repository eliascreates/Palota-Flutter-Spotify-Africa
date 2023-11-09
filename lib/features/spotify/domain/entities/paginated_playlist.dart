import 'playlist.dart';

class PaginatedPlaylist {
  final int offset;
  final int limit;
  final int total;
  final List<Playlist> playlists;

  PaginatedPlaylist({
    required this.offset,
    required this.limit,
    required this.total,
    required this.playlists,
  });

  bool get reachedScrollLimit {
    if ((total - limit) < offset) return true;

    return false;
  }

}
