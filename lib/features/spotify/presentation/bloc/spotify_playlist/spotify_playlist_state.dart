part of 'spotify_playlist_cubit.dart';

enum PlaylistStatus { initial, loading, success, failure }

class SpotifyPlaylistState extends Equatable {
  const SpotifyPlaylistState({
    this.artists = const [],
    this.status = PlaylistStatus.initial,
    this.errorMessage,
    this.playlist = const Playlist(
      description: '',
      totalFollowers: 0,
      id: '',
      imageUrl: '',
      name: '',
      tracks: [],
    ),
  });

  final Playlist playlist;
  final List<Artist> artists;
  final PlaylistStatus status;
  final String? errorMessage;

  SpotifyPlaylistState copyWith({
    Playlist? playlist,
    List<Artist>? artists,
    PlaylistStatus? status,
    String? errorMessage,
  }) {
    return SpotifyPlaylistState(
      playlist: playlist ?? this.playlist,
      artists: artists ?? this.artists,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [playlist, artists, status];
}
