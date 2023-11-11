import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_spotify_africa_assessment/service_locator.dart';

import '../../domain/domain.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class SpotifyPlaylistPage extends StatelessWidget {
  final BriefPlaylistInfo briefPlaylistInfo;

  const SpotifyPlaylistPage({super.key, required this.briefPlaylistInfo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpotifyPlaylistCubit(
        getArtistById: sl<GetArtistById>(),
        getPlaylistById: sl<GetPlaylistById>(),
      )..fetchPlaylistById(playlistId: briefPlaylistInfo.id),
      child: SpotifyPlaylistView(playlistInfo: briefPlaylistInfo),
    );
  }
}

class SpotifyPlaylistView extends StatelessWidget {
  const SpotifyPlaylistView({super.key, required this.playlistInfo});

  final BriefPlaylistInfo playlistInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48.0,
                  ).copyWith(bottom: 15),
                  child: PlaylistDetailImageCard(
                    playlistInfo: playlistInfo,
                  ),
                ),
                const PlaylistDescription(),
                const SizedBox(height: 4),
                const PlaylistFollowers(),
                const SizedBox(height: 16),
                const ColouredDivider(),
                const SizedBox(height: 32),
              ],
            ),
          ),
          const PlaylistTrackList(),
          const PlaylistFeaturedContent(),
        ],
      ),
    );
  }
}
