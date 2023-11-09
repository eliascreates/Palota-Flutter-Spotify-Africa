class PaginatedPlaylist {
  final int offset;
  final int limit;
  final int total;
  final List<BriefPlaylistInfo> briefPlaylistInfo;

  PaginatedPlaylist({
    required this.offset,
    required this.limit,
    required this.total,
    required this.briefPlaylistInfo,
  });

  bool get reachedScrollLimit {
    if ((total - limit) < offset) return true;

    return false;
  }
}

class BriefPlaylistInfo {
  final String id;
  final String imageUrl;
  final String name;

  BriefPlaylistInfo({
    required this.id,
    required this.imageUrl,
    required this.name,
  });
}
