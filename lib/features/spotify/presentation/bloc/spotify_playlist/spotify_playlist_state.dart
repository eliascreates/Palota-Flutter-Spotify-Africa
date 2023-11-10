part of 'spotify_playlist_cubit.dart';

enum PlaylistStatus { initial, loading, success, failure }

class SpotifyPlaylistState extends Equatable {
  const SpotifyPlaylistState({this.status = PlaylistStatus.initial});

  final PlaylistStatus status;

  @override
  List<Object> get props => [status];
}
