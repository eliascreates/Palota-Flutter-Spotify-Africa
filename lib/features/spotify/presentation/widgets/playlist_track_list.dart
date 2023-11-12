import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import 'artist_track_card.dart';

class PlaylistTrackList extends StatelessWidget {
  const PlaylistTrackList({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SpotifyPlaylistCubit>().state;

    final isLoadingStatus = state.status == PlaylistStatus.loading;

    final tracklist = state.playlist.tracks;

    if (tracklist.isEmpty && !isLoadingStatus) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Text(
            "No Tracklist Information",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return SliverAnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isLoadingStatus ? 0 : 1,
      sliver: SliverList.builder(
        itemCount: tracklist.length,
        itemBuilder: (context, index) {
          final track = tracklist[index];
          final artist = track.artistTrackInfo.first;

          return ArtistTrackTile(
            artistName: artist.name,
            songName: track.name,
            imageUrl: track.imageUrl,
            duration: Duration(milliseconds: track.durationInMilliseconds),
          );
        },
      ),
    );
  }
}
