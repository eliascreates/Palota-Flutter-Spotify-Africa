import 'package:dartz/dartz.dart';

import '../entities/entities.dart' show Category;
import '../repositories/spotify_repository.dart';

class GetCategoryById {
  final SpotifyRepository repository;

  GetCategoryById(this.repository);

  Future<Either<String, Category>> call({required String categoryId}) async {
    return await repository.getCategoryById(categoryId: categoryId);
  }
}
