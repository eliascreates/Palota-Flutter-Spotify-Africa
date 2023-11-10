part of 'spotify_bloc.dart';

enum CategoryStatus { initial, loading, success, failure }

class SpotifyCategoryState extends Equatable {
  const SpotifyCategoryState({
    this.pageNumber = 0,
    this.category = const Category(id: '', name: '', imageUrl: '', href: ''),
    this.status = CategoryStatus.loading,
    this.playlists = const [],
    this.playlistPager = const PaginatedPlaylist(
      offset: 0,
      limit: 0,
      total: 0,
      briefPlaylistInfo: [],
    ),
    this.errorMessage,
  });

  final Category category;
  final PaginatedPlaylist? playlistPager;
  final List<BriefPlaylistInfo> playlists;
  final CategoryStatus status;
  final int pageNumber;
  final String? errorMessage;

  SpotifyCategoryState copyWith({
    Category? category,
    PaginatedPlaylist? playlistPager,
    List<BriefPlaylistInfo>? playlists,
    CategoryStatus? status,
    String? errorMessage,
  }) {
    return SpotifyCategoryState(
      category: category ?? this.category,
      playlistPager: playlistPager ?? this.playlistPager,
      playlists: playlists ?? this.playlists,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        playlistPager,
        category,
        pageNumber,
        status,
        errorMessage,
      ];
}
