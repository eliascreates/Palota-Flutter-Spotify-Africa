// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    this.hasReachedScrollLimit = false,
    this.errorMessage,
  });

  final Category category;
  final PaginatedPlaylist playlistPager;
  final List<BriefPlaylistInfo> playlists;
  final CategoryStatus status;
  final int pageNumber;
  final bool hasReachedScrollLimit;
  final String? errorMessage;

  SpotifyCategoryState copyWith({
    Category? category,
    PaginatedPlaylist? playlistPager,
    List<BriefPlaylistInfo>? playlists,
    CategoryStatus? status,
    int? pageNumber,
    bool? hasReachedScrollLimit,
    String? errorMessage,
  }) {
    return SpotifyCategoryState(
      category: category ?? this.category,
      playlistPager: playlistPager ?? this.playlistPager,
      playlists: playlists ?? this.playlists,
      status: status ?? this.status,
      hasReachedScrollLimit:
          hasReachedScrollLimit ?? this.hasReachedScrollLimit,
      pageNumber: pageNumber ?? this.pageNumber,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        playlistPager,
        playlists,
        category,
        pageNumber,
        status,
        hasReachedScrollLimit,
        errorMessage,
      ];

  @override
  String toString() {
    return 'SpotifyCategoryState(playlistPager: $playlistPager, category: $category, playlists: ${playlists.length}, pageNumber: $pageNumber, status: $status, hasReachedScrollLimit: $hasReachedScrollLimit, errorMessage: $errorMessage)';
  }
}
