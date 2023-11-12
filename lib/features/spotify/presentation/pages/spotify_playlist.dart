import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class SpotifyPlaylistPage extends StatefulWidget {
  const SpotifyPlaylistPage({super.key, required this.playlistInfo});

  final BriefPlaylistInfo playlistInfo;

  @override
  State<SpotifyPlaylistPage> createState() => _SpotifyPlaylistPageState();
}

class _SpotifyPlaylistPageState extends State<SpotifyPlaylistPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<SpotifyPlaylistCubit>()
        .fetchPlaylistById(playlistId: widget.playlistInfo.id);
  }

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
                    playlistInfo: widget.playlistInfo,
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
