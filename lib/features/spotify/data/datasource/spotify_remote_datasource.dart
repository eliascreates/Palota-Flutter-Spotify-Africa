import 'dart:convert';

import '../models/models.dart';
import 'package:http/http.dart' as http;

abstract class SpotifyRemoteDataSource {
  Future<CategoryModel> getCategoryById({required String categoryId});

  Future<PaginatedPlaylistModel> getAllCategoryPlaylists({
    required String categoryId,
    int pageNumber = 0,
  });

  Future<PlaylistModel> getPlaylistById({required String playlistId});

  Future<ArtistModel> getArtistById({required String artistId});
}

const limit = 20;

const apiKey = '_q6Qaip9V-PShHzF8q9l5yexp-z9IqwZB_o_6x882ts3AzFuo0DxuQ==';
const baseUrl = 'https://palota-jobs-africa-spotify-fa.azurewebsites.net/api';

const playlistUrl = '$baseUrl/playlists';
const categoryUrl = '$baseUrl/browse/categories';
const artistUrl = '$baseUrl/artists';
const headers = {'x-functions-key': apiKey};

class SpotifyRemoteDataSourceImpl implements SpotifyRemoteDataSource {
  final http.Client client;

  SpotifyRemoteDataSourceImpl({required this.client});

  @override
  Future<CategoryModel> getCategoryById({required String categoryId}) async {
    try {
      final response = await client.get(
        Uri.parse('$categoryUrl/$categoryId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> categoryData = jsonDecode(response.body);

        final category = CategoryModel.fromMap(categoryData);

        return category;
      }
      throw Exception(
        'getCategoryById ($categoryId) reponse failed with status code: ${response.statusCode}',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PaginatedPlaylistModel> getAllCategoryPlaylists({
    required String categoryId,
    int pageNumber = 0,
  }) async {
    try {
      final offset = pageNumber * limit;

      final response = await client.get(
        Uri.parse(
          '$categoryUrl/$categoryId/playlists?limit=$limit&offset=$offset',
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {

        final Map<String, dynamic> data = jsonDecode(response.body);

        final paginatedPlaylist = PaginatedPlaylistModel.fromMap(
          data['playlists'],
        );

        return paginatedPlaylist;
      }

      throw Exception(
        'getAllCategoryPlaylists ($categoryId) response failed with status code: ${response.statusCode}',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ArtistModel> getArtistById({required String artistId}) async {
    try {
      final response =
          await client.get(Uri.parse('$artistUrl/$artistId'), headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> artistData = jsonDecode(response.body);

        final artist = ArtistModel.fromMap(artistData);

        return artist;
      }

      throw Exception(
        'getArtistById ($artistId) response failed with status code: ${response.statusCode}',
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<PlaylistModel> getPlaylistById({required String playlistId}) async {
    try {
      final response = await client.get(Uri.parse('$playlistUrl/$playlistId'),
          headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> playlistData = jsonDecode(response.body);

        final playlist = PlaylistModel.fromMap(playlistData);

        return playlist;
      }
      throw Exception(
        'getPlaylistById ($playlistId) response failed with status code: ${response.statusCode}',
      );
    } catch (_) {
      rethrow;
    }
  }
}
