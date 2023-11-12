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
    emit(
      state.copyWith(status: PlaylistStatus.loadingArtists, errorMessage: null),
    );

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

  Future<void> _getAllFeaturedArtists() async {
    final artistsIds = state.extractAllArtistIds;
    for (final artistId in artistsIds) {
      fetchArtistById(artistId: artistId);
    }
  }

  Future<void> fetchPlaylistById({required String playlistId}) async {
    emit(const SpotifyPlaylistState(status: PlaylistStatus.loading));

    final result = await getPlaylistById(playlistId: playlistId);

    emit(
      await result.fold(
        (failureMessage) async => state.copyWith(
          status: PlaylistStatus.failure,
          errorMessage: failureMessage,
        ),
        (playlist) async {
          return state.copyWith(
            playlist: playlist,
            status: PlaylistStatus.success,
            errorMessage: null,
          );
        },
      ),
    );
    _getAllFeaturedArtists();
  }
}
