import '../../domain/domain.dart' show Track;

class TrackModel extends Track {
  TrackModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.artistMap,
    required super.durationInMilliseconds,
  });

  factory TrackModel.fromMap(Map<String, dynamic> map) {
    return TrackModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? 'Unknown',
      imageUrl: map['album']['images'][0]['url'] as String? ?? '',
      artistMap: List<Map<String, String>>.from(
        (map['artists'] as List<dynamic>? ?? []).map<Map<String, String>>(
          (artist) => {
            'id': artist['id'] as String? ?? '',
            'name': artist['name'] as String? ?? 'Unknown'
          },
        ),
      ),
      durationInMilliseconds: map['duration_ms'] as int? ?? 0,
    );
  }
}
