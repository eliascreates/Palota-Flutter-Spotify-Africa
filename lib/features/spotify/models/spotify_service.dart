import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart' as api;

final credentials = api.SpotifyApiCredentials(
  '5f36b7056c9642f59ed5ed7e77bd36c0', //client_id
  '16f4ed86021a4748955f2b2b40f13bdf', //client_secret
);

final spotify = api.SpotifyApi(credentials);

class SpotifyService {

  static Future<Iterable<api.PlaylistSimple>?> fetchPlaylists(String categoryId) async {
    try {
      var usersPlaylists = await spotify.playlists
          .getByCategoryId(categoryId, country: "SE")
          .all();

      return usersPlaylists;
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  static Future<Iterable<api.PlaylistSimple>?> fetchPlaylistTracks(String categoryId) async {
    try {
      var usersPlaylists = await spotify.playlists
          .getByCategoryId(categoryId, country: "SE")
          .all();

      return usersPlaylists;
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }



}
