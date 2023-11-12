import 'package:dartz/dartz.dart';

import '../entities/entities.dart';

abstract class SpotifyRepository {
  Future<Either<String, Category>> getCategoryById({
    required String categoryId,
  });

  Future<Either<String, PaginatedPlaylist>> getAllCategoryPlaylists({
    required String categoryId,
    required int pageNumber,
  });

  Future<Either<String, Playlist>> getPlaylistById({
    required String playlistId,
  });

  Future<Either<String, Artist>> getArtistById({required String artistId});
}
