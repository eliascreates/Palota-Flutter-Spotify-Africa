import 'package:dartz/dartz.dart';

import '../entities/entities.dart' show PaginatedPlaylist;
import '../repositories/spotify_repository.dart';

class GetAllCategoryPlaylists {
  final SpotifyRepository repository;

  GetAllCategoryPlaylists(this.repository);

  Future<Either<String, PaginatedPlaylist>> call({
    required String categoryId,
    int pageNumber = 1,
  }) async {
    return await repository.getAllCategoryPlaylists(
      categoryId: categoryId,
      pageNumber: pageNumber,
    );
  }
}
