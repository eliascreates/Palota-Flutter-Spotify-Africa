import 'dart:convert';
import 'dart:developer';

import '../models/models.dart';
import 'package:http/http.dart' as http;

abstract class SpotifyRemoteDataSource {
  Future<CategoryModel> getCategoryById({required String categoryId});

  Future<PaginatedPlaylistModel> getAllCategoryPlaylists({
    required String categoryId,
    required int pageNumber,
  });

  Future<PlaylistModel> getPlaylistById({required String playlistId});

  Future<ArtistModel> getArtistById({required String artistId});
}

const limit = 20;

const apiKey = '_q6Qaip9V-PShHzF8q9l5yexp-z9IqwZB_o_6x882ts3AzFuo0DxuQ==';
const baseUrl = 'https://palota-jobs-africa-spotify-fa.azurewebsites.net/api';

const playlistUrl = '$baseUrl/playlists';
const categoryUrl = '$baseUrl/browse/categories';

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

      log('we got a response');
      if (response.statusCode == 200) {
        log('success');
        final Map<String, dynamic> categoryData = jsonDecode(response.body);

        final category = CategoryModel.fromMap(categoryData);

        return category;
      }
      throw Exception(
        'getCategoryById reponse failed with status code: ${response.statusCode}',
      );
    } catch (e) {
      throw Exception('Failed to fetch category by id: $categoryId');
    }
  }

  @override
  Future<PaginatedPlaylistModel> getAllCategoryPlaylists({
    required String categoryId,
    required int pageNumber,
  }) async {
    try {
      final offset = pageNumber * limit;

      final response = await client.get(
        Uri.parse('$playlistUrl/$categoryId?limit=$limit&offset=$offset'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> playlistsData = jsonDecode(response.body);

        final paginatedPlaylist = PaginatedPlaylistModel.fromMap(playlistsData);

        return paginatedPlaylist;
      }

      throw Exception(
          'getAllCategoryPlaylists response failed with status code: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to fetch playlists of category: $categoryId');
    }
  }

  @override
  Future<ArtistModel> getArtistById({required String artistId}) {
    // TODO: implement getArtistById
    throw UnimplementedError();
  }

  @override
  Future<PlaylistModel> getPlaylistById({required String playlistId}) {
    // TODO: implement getPlaylistById
    throw UnimplementedError();
  }
}
