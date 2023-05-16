import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart' as api;

final credentials = api.SpotifyApiCredentials(
  '5f36b7056c9642f59ed5ed7e77bd36c0', //client_id
  '16f4ed86021a4748955f2b2b40f13bdf', //client_secret
);

final spotify = api.SpotifyApi(credentials);

class SpotifyService {
    static Future<Set<api.PlaylistSimple>?> fetchPlaylists(String categoryId,
      {int pageNumber = 0}) async {
    int limit = 10;
    try {
      var userPlaylists = await spotify.playlists
          .getByCategoryId(categoryId, country: "SE")
          .getPage(limit, pageNumber * limit);

      return userPlaylists.items!.toSet();
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

//Fetch Playlist Info
  static Future<api.Playlist?> fetchPlaylistInfo(
    String playlistId,
  ) async {
    try {
      var playlistInfo = await spotify.playlists.get(playlistId);

      return playlistInfo;
    } catch (error) {
      debugPrint(error.toString());
    }

    return null;
  }

  //Fetch playlist Tracklist
  static Future<Set<api.Track>?> fetchPlaylistTracks(
    String playlistId,
  ) async {
    try {
      var userPlaylistTracks =
          await spotify.playlists.getTracksByPlaylistId(playlistId).all();

      return userPlaylistTracks.toSet();
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

//Featured Artists in playlist
  static Future<Set<api.Artist>?> fetchFeaturedArtists(
      Set<api.Track> featuredTracks) async {
    try {
      //Load all artists from featured tracklist
      Set<api.Artist> uniqueArtists = {};

      for (var index = 0; index < featuredTracks.length; index++) {
        if (featuredTracks.elementAt(index).artists!.isNotEmpty) {
          uniqueArtists
              .addAll(featuredTracks.elementAt(index).artists!.toSet());
        }
      }

      var artists = await spotify.artists.list(
        uniqueArtists.map((artist) => artist.id!),
      );

      return artists.toSet();
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }


}
