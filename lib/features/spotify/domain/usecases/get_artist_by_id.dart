import 'package:dartz/dartz.dart';

import '../entities/entities.dart' show Artist;
import '../repositories/spotify_repository.dart';

class GetArtistById {
  final SpotifyRepository repository;

  GetArtistById(this.repository);

  Future<Either<String, Artist>> call({required String artistId}) async {
    return await repository.getArtistById(artistId: artistId);
  }
}
