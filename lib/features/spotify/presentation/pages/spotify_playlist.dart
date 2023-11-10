import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/widgets/playlist_card.dart';

import '../widgets/artist_card.dart';
import '../widgets/artist_track_card.dart';
import '../widgets/playlist_followers.dart';
import '../widgets/show_error_message.dart';

//TODO: complete this page - you may choose to change it to a stateful widget if necessary
class SpotifyPlaylist extends StatelessWidget {
  final String playlistId;

  const SpotifyPlaylist({Key? key, required this.playlistId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          slivers: [
            //In case no data for playlistInfo
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0)
                        .copyWith(bottom: 15),
                    child: const PlaylistDetailCard(
                      imageUrl: '',
                      name: '',
                    ),
                  ),

                  const PlaylistDescription(text: ''),
                  const SizedBox(height: 4),
                  const PlaylistFollowers(total: 1),
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
                  //For errors
                  const ShowErrorMessage(
                    message: "Couldn't Fetch Playlist Information",
                  ),
                ],
              ),
            ),
            //Tracklist
            SliverList.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return const ArtistTrackCard(
                  artistName: '',
                  songName: '',
                  imageUrl: '',
                  duration: Duration.zero,
                );
              },
            ),
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

            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(bottom: 42),
                height: 143,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const ArtistCard(imageUrl: '', artistName: '');
                  },
                ),
              ),
            ),
            const ShowErrorMessage(
              message: "Couldn't Fetch Featured Artists Information",
            ),
            const Center(
                child: CircularProgressIndicator(color: AppColors.cyan)),
          ],
        ));
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
