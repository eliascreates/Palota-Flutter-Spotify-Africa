import 'package:flutter/material.dart';

import 'artist_card.dart';

part 'playlist_featured_header.dart';
part 'playlist_featured_artist_list.dart';

class PlaylistFeaturedContent extends StatelessWidget {
  const PlaylistFeaturedContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverList(
      delegate: SliverChildListDelegate.fixed(
        [
          SizedBox(height: 16),
          FeaturedHeader(title: "Featured Artists"),
          SizedBox(height: 40),
          PlaylistFeaturedArtistList(),
        ],
      ),
    );
  }
}
