import 'package:dartz/dartz.dart';

import '../../domain/domain.dart';
import '../datasource/spotify_remote_datasource.dart';

class SpotifyRepositoryImpl implements SpotifyRepository {
  final SpotifyRemoteDataSource remoteDataSource;

  const SpotifyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<Playlist>>> getAllCategoryPlaylists({
    required String categoryId,
  }) async {
    // TODO: implement getAllCategoryPlaylists
    try {
      final playlists = await remoteDataSource.getAllCategoryPlaylists(
        categoryId: categoryId,
      );

      return Right(playlists);
    } catch (e) {
      return Left('Unable to fetch playlists: $e');
    }
  }

  @override
  Future<Either<String, Artist>> getArtistById(
      {required String artistId}) async {
    // TODO: implement getArtistById
    try {
      final artist = await remoteDataSource.getArtistById(artistId: artistId);

      return Right(artist);
    } catch (e) {
      return Left('Unable to fetch artist: $e');
    }
  }

  @override
  Future<Either<String, Category>> getCategoryById({
    required String categoryId,
  }) async {
    // TODO: implement getCategoryById
    try {
      final category = await remoteDataSource.getCategoryById(
        categoryId: categoryId,
      );

      return Right(category);
    } catch (e) {
      return Left('Unable to fetch category: $e');
    }
  }

  @override
  Future<Either<String, Playlist>> getPlaylistById({
    required String playlistId,
  }) async {
    // TODO: implement getPlaylistById
    try {
      final playlist = await remoteDataSource.getPlaylistById(
        playlistId: playlistId,
      );

      return Right(playlist);
    } catch (e) {
      return Left('Unable to fetch playlist: $e');
    }
  }
}
