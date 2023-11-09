import 'package:dartz/dartz.dart';

import '../entities/entities.dart' show Playlist;
import '../repositories/spotify_repository.dart';

class GetAllCategoryPlaylists {
  final SpotifyRepository repository;

  GetAllCategoryPlaylists(this.repository);

  Future<Either<String, List<Playlist>>> call({
    required String categoryId,
  }) async {
    return await repository.getAllCategoryPlaylists(categoryId: categoryId);
  }
}
