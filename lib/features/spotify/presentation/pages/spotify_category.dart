import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/models/spotify_service.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';
import 'package:spotify/spotify.dart' as api;

import '../components/category_header.dart';
import '../components/playlist_card.dart';

// TODO: fetch and populate playlist info and allow for click-through to detail
// Feel free to change this to a stateful widget if necessary

class SpotifyCategory extends StatefulWidget {
  final String categoryId;

  const SpotifyCategory({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<SpotifyCategory> createState() => _SpotifyCategoryState();
}

class _SpotifyCategoryState extends State<SpotifyCategory> {
  bool isLoading = true; // Load Playlist on start up
  bool isLoadingMore = false; // Load more playlist - pagination
  int pageNumber = 0; // shows 10 playlists per page

  Set<api.PlaylistSimple> playlists = {};

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollRefreshListener);
    fetchPlaylists(widget.categoryId, pageNumber: 0);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.categoryId[0].toUpperCase() + widget.categoryId.substring(1),
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
      body: !isLoading //Shows loading widget if playlists still being fetched
          ? CustomScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      CategoryHeader(
                        imageUrl: playlists.last.images!.first.url!,
                        categoryId: widget.categoryId,
                        categoryType: playlists.first.type!,
                      ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  sliver: SliverGrid.builder(
                    itemCount:
                        isLoadingMore ? playlists.length + 1 : playlists.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 163 / 212,
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      if (index < playlists.length) {
                        return PlaylistCard(
                          onPress: () => _navigateToSpotifyPlaylistPage(
                              context, playlists.elementAt(index).id!),
                          imageUrl:
                              playlists.elementAt(index).images!.first.url!,
                          playlistName: playlists.elementAt(index).name!,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            )
          : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
              ],
            ),
    );
  }

  void _scrollRefreshListener() async {
    // Makes sure a call is complete before another is made
    if (isLoadingMore) {
      return;
    }

    //Loads more playlists when user scrolls to max scroll extent
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });

      pageNumber++;
      await fetchPlaylists(widget.categoryId, pageNumber: pageNumber);

      setState(() {
        isLoadingMore = false;
      });
    }
  }

  Future<void> fetchPlaylists(String categoryId, {int pageNumber = 0}) async {
    int limit = 10;
    try {
      var userPlaylists = await spotify.playlists
          .getByCategoryId(categoryId, country: "SE")
          .getPage(limit, pageNumber * limit);

      setState(() {
        playlists.addAll(userPlaylists.items!.toSet());
        isLoading = false;
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void _navigateToSpotifyPlaylistPage(
      BuildContext context, String spotifyPlaylistId) {
    Navigator.of(context)
        .pushNamed(AppRoutes.spotifyPlaylist, arguments: spotifyPlaylistId);
  }
}
