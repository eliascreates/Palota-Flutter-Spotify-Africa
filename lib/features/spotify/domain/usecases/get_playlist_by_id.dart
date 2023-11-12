import 'package:dartz/dartz.dart';

import '../entities/entities.dart' show Playlist;
import '../repositories/spotify_repository.dart';

class GetPlaylistById {
  final SpotifyRepository repository;

  GetPlaylistById(this.repository);

  Future<Either<String, Playlist>> call({required String playlistId}) async {
    return await repository.getPlaylistById(playlistId: playlistId);
  }
}
