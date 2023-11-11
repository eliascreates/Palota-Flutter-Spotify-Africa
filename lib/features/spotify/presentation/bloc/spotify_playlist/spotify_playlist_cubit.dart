import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';

part 'spotify_playlist_state.dart';

class SpotifyPlaylistCubit extends Cubit<SpotifyPlaylistState> {
  final GetArtistById getArtistById;
  final GetPlaylistById getPlaylistById;
  SpotifyPlaylistCubit({
    required this.getArtistById,
    required this.getPlaylistById,
  }) : super(const SpotifyPlaylistState());

  Future<void> fetchArtistById({required String artistId}) async {
    emit(state.copyWith(status: PlaylistStatus.loading, errorMessage: null));

    final result = await getArtistById(artistId: artistId);

    emit(
      await result.fold(
        (failureMessage) async => state.copyWith(
          status: PlaylistStatus.failure,
          errorMessage: failureMessage,
        ),
        (artist) async => state.copyWith(
          artists: List.of(state.artists)..add(artist),
          status: PlaylistStatus.success,
          errorMessage: null,
        ),
      ),
    );
  }

  Future<void> fetchPlaylistById({required String playlistId}) async {
    emit(state.copyWith(status: PlaylistStatus.loading, errorMessage: null));

    final result = await getPlaylistById(playlistId: playlistId);

    emit(
      await result.fold(
        (failureMessage) async => state.copyWith(
          status: PlaylistStatus.failure,
          errorMessage: failureMessage,
        ),
        (playlist) async => state.copyWith(
          playlist: playlist,
          status: PlaylistStatus.success,
          errorMessage: null,
        ),
      ),
    );
  }
}
