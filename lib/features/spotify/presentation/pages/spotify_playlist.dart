import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/playlist_card.dart';

import '../components/artist_card.dart';
import '../components/artist_track_card.dart';

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
                      imageUrl:
                          'https://i.pinimg.com/564x/63/af/7d/63af7dbe1b41480f8b1985a9232d647c.jpg',
                      playlistName: 'Afro bashment'),
                ),

                const PlaylistDescription(
                  text:
                      "The best in Afro Bashment, Afro Swing and all that good stuff. Cover: Davido",
                ),
                const SizedBox(height: 4),
                const PlaylistFollowers(numFollowers: "286, 850"),
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
            itemCount: 5,
            itemBuilder: (context, index) {
              return const ArtistTrackCard(
                artistName: "Ayra Star",
                songName: "Rush",
                imageUrl:
                    'https://i.pinimg.com/236x/d4/ae/c6/d4aec6417dfbe9f757a269c57eddf524.jpg',
                duration: "3:05",
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
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return const ArtistCard(
                      imageUrl:
                          'https://i.pinimg.com/236x/31/61/90/316190f3c9b18aaf08b7a4cb2ab6a2bc.jpg',
                      artistName: 'Ayra Star');
                },
              ),
            ),
          ),
        ],
      ),
    );
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
