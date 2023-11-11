import '../../domain/domain.dart' show Track, ArtistTrackInfo;

class TrackModel extends Track {
  final List<ArtistTrackInfoModel> artistTrackInfoModel;

  TrackModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required this.artistTrackInfoModel,
    required super.durationInMilliseconds,
  }) : super(artistTrackInfo: artistTrackInfoModel);

  factory TrackModel.fromMap(Map<String, dynamic> map) {
    return TrackModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? 'Unknown',
      imageUrl: map['album']['images'][2]['url'] as String? ?? '',

      artistTrackInfoModel: List<ArtistTrackInfoModel>.from(
        (map['artists'] as List<dynamic>).map<ArtistTrackInfo>(
          (artistInfo) => ArtistTrackInfoModel.fromMap(
            artistInfo as Map<String, dynamic>,
          ),
        ),
      ),
      durationInMilliseconds: map['duration_ms'] as int? ?? 0,
    );
  }
}

class ArtistTrackInfoModel extends ArtistTrackInfo {
  ArtistTrackInfoModel({
    required super.id,
    required super.name,
  });

  factory ArtistTrackInfoModel.fromMap(Map<String, dynamic> map) {
    return ArtistTrackInfoModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? 'Unknown',
    );
  }
}
