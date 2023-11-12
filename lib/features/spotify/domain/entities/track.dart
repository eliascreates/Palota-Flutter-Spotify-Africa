class Track {
  final String id;
  final String name;
  final String imageUrl;
  final List<ArtistTrackInfo> artistTrackInfo;
  final int durationInMilliseconds;

  Track({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.artistTrackInfo,
    required this.durationInMilliseconds,
  });
}

class ArtistTrackInfo {
  final String id;
  final String name;

  ArtistTrackInfo({
    required this.id,
    required this.name,
  });
}
