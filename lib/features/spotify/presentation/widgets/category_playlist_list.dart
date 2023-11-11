import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/domain/domain.dart';

import 'package:flutter_spotify_africa_assessment/routes.dart';

import '../bloc/bloc.dart';
import 'category_playlist_card.dart';

class CategoryPlaylistList extends StatelessWidget {
  const CategoryPlaylistList({super.key});

  @override
  Widget build(BuildContext context) {
    final playlists = context.select(
      (SpotifyBloc bloc) => bloc.state.playlists,
    );

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      sliver: SliverGrid.builder(
        itemCount: playlists.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 163 / 212,
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          final currentPlaylist = playlists[index];

          return CategoryPlaylistCard(
            playlistInfo: currentPlaylist,
            onTap: () {
              _navigateToSpotifyPlaylistPage(context, currentPlaylist);
            },
          );
        },
      ),
    );
  }

  void _navigateToSpotifyPlaylistPage(
    BuildContext context,
    BriefPlaylistInfo currentPlaylist,
  ) {
    Navigator.of(context).pushNamed(
      AppRoutes.spotifyPlaylist,
      arguments: currentPlaylist,
    );
  }
}
