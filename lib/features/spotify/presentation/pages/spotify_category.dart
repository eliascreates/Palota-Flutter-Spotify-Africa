import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';

import '../bloc/spotify_category_bloc/spotify_category_bloc.dart';
import '../components/category_header.dart';
import '../components/playlist_card.dart';

// TODO: fetch and populate playlist info and allow for click-through to detail
// Feel free to change this to a stateful widget if necessary

class SpotifyCategoryPage extends StatelessWidget {
  final String categoryId;

  const SpotifyCategoryPage({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpotifyCategoryBloc()
        ..add(
          SpotifyCategoryPlaylistsFetched(
            categoryId: categoryId,
            pageNumber: 0,
          ),
        ),
      child: SpotifyCategoryView(categoryId: categoryId),
    );
  }
}

class SpotifyCategoryView extends StatelessWidget {
  const SpotifyCategoryView({super.key, required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          categoryId[0].toUpperCase() + categoryId.substring(1),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.about),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
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
      body: BlocBuilder<SpotifyCategoryBloc, SpotifyCategoryState>(
        builder: (context, state) {
          if (state.status == CategoryStatus.loading) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator(color: AppColors.cyan)),
              ],
            );
          }
          final paginatedPlaylist = state.paginatedPlaylist!;

          final playlists = paginatedPlaylist.briefPlaylistInfo;

          return CustomScrollView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    CategoryHeader(
                      imageUrl: '',
                      categoryId: categoryId,
                      categoryType: '',
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                sliver: SliverGrid.builder(
                  itemCount: playlists.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 163 / 212,
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return PlaylistCard(
                      onPress: () => _navigateToSpotifyPlaylistPage(
                        context,
                        playlists.elementAt(index).id,
                      ),
                      imageUrl: '',
                      playlistName: '',
                    );
                  },
                ),
              ),
              const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.cyan),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _navigateToSpotifyPlaylistPage(
    BuildContext context,
    String spotifyPlaylistId,
  ) {
    Navigator.of(context).pushNamed(
      AppRoutes.spotifyPlaylist,
      arguments: spotifyPlaylistId,
    );
  }
}
