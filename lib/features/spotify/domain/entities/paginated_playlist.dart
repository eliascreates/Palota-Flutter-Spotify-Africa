class PaginatedPlaylist {
  final int offset;
  final int limit;
  final int total;
  final List<BriefPlaylistInfo> briefPlaylistInfo;

  const PaginatedPlaylist({
    required this.offset,
    required this.limit,
    required this.total,
    required this.briefPlaylistInfo,
  });

}

class BriefPlaylistInfo {
  final String id;
  final String imageUrl;
  final String name;

  const BriefPlaylistInfo({
    required this.id,
    required this.imageUrl,
    required this.name,
  });
}
