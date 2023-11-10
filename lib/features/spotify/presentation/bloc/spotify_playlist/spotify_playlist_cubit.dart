import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'spotify_playlist_state.dart';

class SpotifyPlaylistCubit extends Cubit<SpotifyPlaylistState> {
  SpotifyPlaylistCubit() : super(const SpotifyPlaylistState());
}
