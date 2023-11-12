import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import 'artist_card.dart';

part 'playlist_featured_artist_list.dart';
part 'playlist_featured_header.dart';

class PlaylistFeaturedContent extends StatelessWidget {
  const PlaylistFeaturedContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          const SizedBox(height: 16),
          const FeaturedHeader(),
          const SizedBox(height: 40),
          const PlaylistFeaturedArtistList(),
        ],
      ),
    );
  }
}
