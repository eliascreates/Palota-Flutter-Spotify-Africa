part of 'spotify_category_bloc.dart';

abstract class SpotifyCategoryEvent extends Equatable {
  const SpotifyCategoryEvent();

  @override
  List<Object> get props => [];
}

class SpotifyCategoryFetchedById extends SpotifyCategoryEvent {
  final String categoryId;

  const SpotifyCategoryFetchedById({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class SpotifyCategoryPlaylistsFetched extends SpotifyCategoryEvent {
  final String categoryId;
  final int pageNumber;

  const SpotifyCategoryPlaylistsFetched({
    required this.categoryId,
    required this.pageNumber,
  });

  @override
  List<Object> get props => [categoryId, pageNumber];
}

class SpotifyArtistFetchedById extends SpotifyCategoryEvent {
  final String artistId;

  const SpotifyArtistFetchedById({required this.artistId});

  @override
  List<Object> get props => [artistId];
}

class SpotifyPlaylistFetchedById extends SpotifyCategoryEvent {
  final String playlistId;

  const SpotifyPlaylistFetchedById({required this.playlistId});

  @override
  List<Object> get props => [playlistId];
}
