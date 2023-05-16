import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/playlist_card.dart';
import 'package:spotify/spotify.dart' as api;

import '../../models/spotify_service.dart';
import '../components/artist_card.dart';
import '../components/artist_track_card.dart';

//TODO: complete this page - you may choose to change it to a stateful widget if necessary
class SpotifyPlaylist extends StatefulWidget {
  final String playlistId;

  const SpotifyPlaylist({Key? key, required this.playlistId}) : super(key: key);

  @override
  State<SpotifyPlaylist> createState() => _SpotifyPlaylistState();
}

class _SpotifyPlaylistState extends State<SpotifyPlaylist> {
  bool _isLoading = true;

  api.Playlist _playlistInfo = api.Playlist();
  Set<api.Track> playlistTracks = {};
  Set<api.Artist> _featuredArtists = {};

  @override
  void initState() {
    super.initState();
    fetchPlaylistTracks(widget.playlistId);
    fetchPlaylistInfo(widget.playlistId);
    fetchFeaturedArtists(widget.playlistId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: !_isLoading
          ? CustomScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48.0)
                            .copyWith(bottom: 15),
                        child: PlaylistCard(
                            fontSize: 22,
                            imageRadius: 12,
                            fontWeight: FontWeight.w400,
                            textPadding: 15,
                            containerRadius: 24,
                            containerPadding: 15,
                            imageSize: 263,
                            onPress: () {},
                            imageUrl: _playlistInfo.images!.first.url!,
                            playlistName: _playlistInfo.name!),
                      ),

                      PlaylistDescription(text: _playlistInfo.description!),
                      const SizedBox(height: 4),
                      PlaylistFollowers(
                          numFollowers:
                              _playlistInfo.followers!.total.toString()),
                      const SizedBox(height: 16),

                      //Coloured Divider
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 4,
                          width: 326,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                AppColors.blue,
                                AppColors.cyan,
                                AppColors.green,
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),

                //Tracklist
                SliverList.builder(
                  itemCount: 7, //playlistTracks.length,
                  itemBuilder: (context, index) {
                    return ArtistTrackCard(
                      artistName:
                          playlistTracks.elementAt(index).artists!.first.name!,
                      songName: playlistTracks.elementAt(index).name!,
                      imageUrl: playlistTracks
                          .elementAt(index)
                          .album!
                          .images!
                          .first
                          .url!,
                      duration: playlistTracks
                          .elementAt(index)
                          .duration!
                          .inMinutes
                          .toString(),
                    );
                  },
                ),

                //Featured Artists
                const SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      SizedBox(height: 16),
                      FeaturedHeader(title: "Featured Artists"),
                      SizedBox(height: 40),
                    ],
                  ),
                ),

                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 42),
                    height: 143,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: _featuredArtists.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ArtistCard(
                            imageUrl: _featuredArtists
                                .elementAt(index)
                                .images!
                                .first
                                .url!,
                            artistName:
                                _featuredArtists.elementAt(index).name!);
                      },
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

//Fetch Playlist Info
  Future<void> fetchPlaylistInfo(
    String playlistId,
  ) async {
    try {
      var playlistInfo = await spotify.playlists.get(playlistId);
      setState(() {
        _playlistInfo = playlistInfo;
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  //Fetch playlist Tracklist
  Future<void> fetchPlaylistTracks(
    String playlistId,
  ) async {
    try {
      var userPlaylistTracks =
          await spotify.playlists.getTracksByPlaylistId(playlistId).all();

      setState(() {
        playlistTracks.addAll(userPlaylistTracks.toSet());
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }

//Featured Artists in playlist
  Future<void> fetchFeaturedArtists(
    String playlistId,
  ) async {
    try {
      //Get tracks in playlist
      var featuredTracks =
          await spotify.playlists.getTracksByPlaylistId(playlistId).all();

      featuredTracks = featuredTracks.take(10); // Limiting it to on

      //This loop makes a unique list of artists in each and every track in a lists
      for (var index = 0; index < featuredTracks.length; index++) {
        if (featuredTracks.elementAt(index).artists!.isNotEmpty) {
          _featuredArtists
              .addAll(featuredTracks.elementAt(index).artists!.toSet());
        }
      }

      //Showing only first 10 artists to minimize requests made
      _featuredArtists = _featuredArtists.take(10).toSet();
      var artists =
          await spotify.artists.list(_featuredArtists.map((e) => e.id!));
      _featuredArtists = artists.toSet();

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}

class PlaylistFollowers extends StatelessWidget {
  const PlaylistFollowers({
    super.key,
    required this.numFollowers,
  });

  final String numFollowers;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 195,
          padding: const EdgeInsets.symmetric(vertical: 8).copyWith(right: 16),
          decoration: const BoxDecoration(
            color: Color(0xFF211F26),
            borderRadius:
                BorderRadiusDirectional.horizontal(start: Radius.circular(12)),
          ),
          child: Text(
            "$numFollowers Followers",
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  fontSize: 11,
                ),
          ),
        ),
      ],
    );
  }
}

class PlaylistDescription extends StatelessWidget {
  const PlaylistDescription({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        overflow: TextOverflow.clip,
        maxLines: 2,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              letterSpacing: 0.5,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
