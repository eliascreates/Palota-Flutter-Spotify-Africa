part of 'spotify_playlist_cubit.dart';

enum PlaylistStatus { initial, loading, loadingArtists, success, failure }

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

  List<String> get extractAllArtistIds {
    if (playlist.tracks.isEmpty) return [];

    List<String> ids = [];
    for (final track in playlist.tracks) {
      ids.addAll(track.artistTrackInfo.map((a) => a.id));
    }
    return ids;
  }

  @override
  String toString() =>
      'SpotifyPlaylistState(playlist: $playlist, artists: ${artists.length}, status: $status, errorMessage: $errorMessage)';

  @override
  List<Object?> get props => [playlist, artists, status, errorMessage];
}
