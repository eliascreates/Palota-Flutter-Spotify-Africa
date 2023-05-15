import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/playlist_card.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 195,
                padding:
                    const EdgeInsets.symmetric(vertical: 8).copyWith(right: 16),
                decoration: const BoxDecoration(
                  color: Color(0xFF211F26),
                  borderRadius: BorderRadiusDirectional.horizontal(
                      start: Radius.circular(12)),
                ),
                child: Text(
                  "286, 850 Followers",
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        fontSize: 11,
                      ),
                ),
              ),
            ],
          )
        ],
      ),
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
