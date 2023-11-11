part of 'playlist_featured_content.dart';

class PlaylistFeaturedArtistList extends StatelessWidget {
  const PlaylistFeaturedArtistList({super.key});

  @override
  Widget build(BuildContext context) {
    // final playlist = context.select(
    //   (SpotifyPlaylistCubit cubit) => cubit.state.playlist,
    // );

    // final artists = playlist.tracks.map

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(bottom: 42),
        height: 143,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 1,
          itemBuilder: (context, index) {
            return const ArtistCard(imageUrl: '', artistName: '');
          },
        ),
      ),
    );
  }
}

// const ShowErrorMessage(
//             message: "Couldn't Fetch Featured Artists Information",
//           ),