import '../../domain/domain.dart' show Artist;

class ArtistModel extends Artist {
  ArtistModel({
    required super.id,
    required super.name,
    required super.genres,
    required super.imageUrl,
    required super.totalFollowers,
  });

  factory ArtistModel.fromMap(Map<String, dynamic> map) {
    return ArtistModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? 'Unknown',
      imageUrl: map['images'][0]['url'] as String? ?? '',
      totalFollowers: map['followers']['total'] as int? ?? 0,
      genres: List<String>.from((map['genres'] as List<dynamic>? ?? [])),
    );
  }
}
