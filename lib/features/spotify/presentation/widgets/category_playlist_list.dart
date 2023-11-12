import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_spotify_africa_assessment/routes.dart';

import '../../domain/domain.dart';
import '../bloc/bloc.dart';
import 'category_playlist_card.dart';

class CategoryPlaylistList extends StatefulWidget {
  const CategoryPlaylistList(
    this.scrollController, {
    super.key,
    required this.categoryId,
  });

  final String categoryId;
  final ScrollController scrollController;
  @override
  State<CategoryPlaylistList> createState() => _CategoryPlaylistListState();
}

class _CategoryPlaylistListState extends State<CategoryPlaylistList> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_fetchPlaylistsOnScroll);
  }

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

  bool get _isBottomOfList {
    if (!widget.scrollController.hasClients) return false;
    final maxScrollExtent = widget.scrollController.position.maxScrollExtent;
    final currentScrollPosition = widget.scrollController.offset;

    return currentScrollPosition >= maxScrollExtent;
  }

  void _fetchPlaylistsOnScroll() {
    if (_isBottomOfList) {
      context.read<SpotifyBloc>().add(
            SpotifyCategoryPlaylistsFetched(
              categoryId: widget.categoryId,
            ),
          );
    }
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
