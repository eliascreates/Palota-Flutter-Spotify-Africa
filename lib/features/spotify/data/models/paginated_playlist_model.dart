import '../../domain/domain.dart' show BriefPlaylistInfo, PaginatedPlaylist;

class PaginatedPlaylistModel extends PaginatedPlaylist {
  final List<BriefPlaylistInfoModel> briefPlaylistInfoModel;

  PaginatedPlaylistModel({
    required super.offset,
    required super.limit,
    required super.total,
    required this.briefPlaylistInfoModel,
  }) : super(briefPlaylistInfo: briefPlaylistInfoModel);

  factory PaginatedPlaylistModel.fromMap(Map<String, dynamic> map) {
    return PaginatedPlaylistModel(
      offset: map['offset'] as int,
      limit: map['limit'] as int,
      total: map['total'] as int,
      briefPlaylistInfoModel: List<BriefPlaylistInfoModel>.from(
        (map['items'] as List<dynamic>? ?? []).map<BriefPlaylistInfoModel>(
          (briefPlaylist) => BriefPlaylistInfoModel.fromMap(
            briefPlaylist as Map<String, dynamic>,
          ),
        ),
      ),
    );
  }
}

class BriefPlaylistInfoModel extends BriefPlaylistInfo {
  BriefPlaylistInfoModel({
    required super.id,
    required super.imageUrl,
    required super.name,
  });

  factory BriefPlaylistInfoModel.fromMap(Map<String, dynamic> map) {
    return BriefPlaylistInfoModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? 'Unknown',
      imageUrl: map['images'][0]['url'] as String? ?? '',
    );
  }
}
