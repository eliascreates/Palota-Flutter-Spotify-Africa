import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/models/spotify_service.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';
import 'package:spotify/spotify.dart' as api;

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
    userPlaylist = SpotifyService.fetchPlaylist(widget.categoryId);
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
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: FutureBuilder(
            future: userPlaylist,
            builder: (context, snapshot) {
              debugPrint("the snapshot $snapshot");
              if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(snapshot.data!.elementAt(index).name!),
                        SizedBox(
                          width: 100,
                          child: Image.network(
                              fit: BoxFit.cover,
                              snapshot.data!
                                  .elementAt(index)
                                  .images!
                                  .first
                                  .url!),
                        ),
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.hasError}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
