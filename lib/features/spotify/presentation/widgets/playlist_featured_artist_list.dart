part of 'playlist_featured_content.dart';

class PlaylistFeaturedArtistList extends StatefulWidget {
  const PlaylistFeaturedArtistList({super.key});

  @override
  State<PlaylistFeaturedArtistList> createState() =>
      _PlaylistFeaturedArtistListState();
}

class _PlaylistFeaturedArtistListState
    extends State<PlaylistFeaturedArtistList> {
  @override
  void initState() {
    super.initState();
    context.read<SpotifyPlaylistCubit>().getAllFeaturedArtists();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SpotifyPlaylistCubit>().state;
    final isLoadingArtistStatus = state.status == PlaylistStatus.loadingArtists;
    final isLoadingStatus = state.status == PlaylistStatus.loading;
    final isNotLoading = !isLoadingArtistStatus && !isLoadingStatus;

    final artists = context.select(
      (SpotifyPlaylistCubit cubit) => cubit.state.artists,
    );

    if (artists.isEmpty && isNotLoading) {
      return const SizedBox(
        height: 100,
        child: Center(
          child: Text(
            "No Featured Artists Information",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isLoadingArtistStatus ? 0 : 1,
      child: Container(
        margin: const EdgeInsets.only(bottom: 42),
        height: 145,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: artists.length,
          itemBuilder: (context, index) {
            final artist = artists[index];

            return ArtistCard(
              imageUrl: artist.imageUrl,
              artistName: artist.name,
            );
          },
        ),
      ),
    );
  }
}
