import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/domain/domain.dart';

part 'spotify_playlist_state.dart';

class SpotifyPlaylistCubit extends Cubit<SpotifyPlaylistState> {
  SpotifyPlaylistCubit() : super(const SpotifyPlaylistState());

  void fetchArtistById({required String artistId}) {}
  void fetchPlaylistById({required String playlistId}) {}
}
