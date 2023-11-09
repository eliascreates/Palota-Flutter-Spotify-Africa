import '../models/models.dart';
import 'package:http/http.dart' as http;

abstract class SpotifyRemoteDataSource {
  Future<CategoryModel> getCategoryById({required String categoryId});

  Future<List<PlaylistModel>> getAllCategoryPlaylists({
    required String categoryId,
  });

  Future<PlaylistModel> getPlaylistById({required String playlistId});

  Future<ArtistModel> getArtistById({required String artistId});
}

class SpotifyRemoteDataSourceImpl implements SpotifyRemoteDataSource {
  final http.Client client;

  SpotifyRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PlaylistModel>> getAllCategoryPlaylists({
    required String categoryId,
  }) {
    // TODO: implement getAllCategoryPlaylists
    throw UnimplementedError();
  }

  @override
  Future<ArtistModel> getArtistById({required String artistId}) {
    // TODO: implement getArtistById
    throw UnimplementedError();
  }

  @override
  Future<CategoryModel> getCategoryById({required String categoryId}) {
    // TODO: implement getCategoryById
    throw UnimplementedError();
  }

  @override
  Future<PlaylistModel> getPlaylistById({required String playlistId}) {
    // TODO: implement getPlaylistById
    throw UnimplementedError();
  }
}
