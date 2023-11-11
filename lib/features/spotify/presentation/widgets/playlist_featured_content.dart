import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import 'artist_card.dart';

part 'playlist_featured_artist_list.dart';
part 'playlist_featured_header.dart';

class PlaylistFeaturedContent extends StatefulWidget {
  const PlaylistFeaturedContent({super.key});

  @override
  State<PlaylistFeaturedContent> createState() =>
      _PlaylistFeaturedContentState();
}

class _PlaylistFeaturedContentState extends State<PlaylistFeaturedContent> {
  @override
  void initState() {
    super.initState();
    context.read<SpotifyPlaylistCubit>().getAllFeaturedArtists();
  }

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
