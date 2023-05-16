import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/playlist_card.dart';
import 'package:spotify/spotify.dart' as api;

import '../../services/spotify_service.dart';
import '../components/artist_card.dart';
import '../components/artist_track_card.dart';
import '../components/playlist_followers.dart';
import '../components/show_error_message.dart';

//TODO: complete this page - you may choose to change it to a stateful widget if necessary
class SpotifyPlaylist extends StatefulWidget {
  final String playlistId;

  const SpotifyPlaylist({Key? key, required this.playlistId}) : super(key: key);

  @override
  State<SpotifyPlaylist> createState() => _SpotifyPlaylistState();
}

class _SpotifyPlaylistState extends State<SpotifyPlaylist> {
  bool _isLoading = true;

  api.Playlist? _playlistInfo = api.Playlist();
  Set<api.Track>? playlistTracks = {};
  Set<api.Artist>? _featuredArtists = {};

  @override
  void initState() {
    super.initState();

    loadData(widget.playlistId);
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
                if (_playlistInfo != null) //In case no data for playlistInfo
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
                              imageUrl: _playlistInfo!.images!.first.url!,
                              playlistName: _playlistInfo!.name!),
                        ),

                        PlaylistDescription(text: _playlistInfo!.description!),
                        const SizedBox(height: 4),
                        PlaylistFollowers(
                            numFollowers: _playlistInfo!.followers!.total),
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
                  )
                else
                  const ShowErrorMessage(
                    message: "Couldn't Fetch Playlist Information",
                  ),

                //Tracklist
                if (playlistTracks != null)
                  SliverList.builder(
                    itemCount: playlistTracks!.length,
                    itemBuilder: (context, index) {
                      return ArtistTrackCard(
                        artistName: playlistTracks!
                            .elementAt(index)
                            .artists!
                            .first
                            .name!,
                        songName: playlistTracks!.elementAt(index).name!,
                        imageUrl: playlistTracks!
                            .elementAt(index)
                            .album!
                            .images!
                            .first
                            .url!,
                        duration: playlistTracks!.elementAt(index).duration!,
                      );
                    },
                  )
                else
                  const ShowErrorMessage(
                    message: "Couldn't Fetch Tracklist Information",
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
                if (_featuredArtists != null)
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 42),
                      height: 143,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: _featuredArtists!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ArtistCard(
                              imageUrl: _featuredArtists!
                                      .elementAt(index)
                                      .images
                                      // ignore: sdk_version_since
                                      ?.elementAtOrNull(0)
                                      ?.url ?? // When artist image is null display default image
                                  "https://i.pinimg.com/236x/63/c0/54/63c054fe3af6cc5e37bba5655a32a6a0.jpg",
                              artistName:
                                  _featuredArtists!.elementAt(index).name!);
                        },
                      ),
                    ),
                  )
                else
                  const ShowErrorMessage(
                    message: "Couldn't Fetch Featured Artists Information",
                  ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(color: AppColors.cyan)),
    );
  }

  //Load Data Before Showing anything
  Future<void> loadData(String playlistId) async {
    _playlistInfo = await SpotifyService.fetchPlaylistInfo(playlistId);

    playlistTracks = await SpotifyService.fetchPlaylistTracks(playlistId);

    //if track information exists, get featured artists
    if (playlistTracks != null) {
      //Limiting to 10 for ease of presentation and to minimize api requests made
      playlistTracks = playlistTracks!.take(10).toSet();
      _featuredArtists =
          await SpotifyService.fetchFeaturedArtists(playlistTracks!);
    }

    setState(() {
      _isLoading = false;
    });
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
