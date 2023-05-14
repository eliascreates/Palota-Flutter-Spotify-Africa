import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/models/spotify_service.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';
import 'package:spotify/spotify.dart' as api;

import 'components/category_header.dart';
import 'components/playlist_card.dart';

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
  late Future<Iterable<api.PlaylistSimple>?> userPlaylist;

  @override
  void initState() {
    super.initState();
    userPlaylist = SpotifyService.fetchPlaylists(widget.categoryId);
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
      body: FutureBuilder(
        future: userPlaylist,
        builder: (context, snapshot) {
          debugPrint("the snapshot $snapshot");
          if (snapshot.hasData) {
            return CustomScrollView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      CategoryHeader(
                        imageUrl: snapshot.data!.last.images!.first.url!,
                        categoryId: widget.categoryId,
                        categoryType: snapshot.data!.first.type!,
                      ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  sliver: SliverGrid.builder(
                    itemCount: snapshot.data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 163 / 212,
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) => PlaylistCard(
                      onPress: () {},
                      imageUrl:
                          snapshot.data!.elementAt(index).images!.first.url!,
                      playlistName: snapshot.data!.elementAt(index).name!,
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            
            return Text('${snapshot.hasError}');
          }
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator()),
            ],
          );
        },
      ),
    );
  }

  // void _navigateToSpotifyPlaylistPage(BuildContext context) {
  //   Navigator.of(context).pushNamed(AppRoutes.spotifyPlaylist,
  //       arguments: LandingPage._spotifyCategoryId);
  // }
}
