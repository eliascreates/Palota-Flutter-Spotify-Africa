part of 'playlist_featured_content.dart';

class PlaylistFeaturedArtistList extends StatelessWidget {
  const PlaylistFeaturedArtistList({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SpotifyPlaylistCubit>().state;
    final isLoadingArtistStatus = state.status == PlaylistStatus.loadingArtists;
    final isLoadingPlaylistStatus = state.status == PlaylistStatus.loading;
    final isNotLoading = !isLoadingArtistStatus && !isLoadingPlaylistStatus;

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
