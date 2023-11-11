import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/domain.dart';

class PlaylistDetailImageCard extends StatelessWidget {
  final BriefPlaylistInfo playlistInfo;
  const PlaylistDetailImageCard({super.key, required this.playlistInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: const Color(0xFF211F26),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'PlaylistCard/${playlistInfo.id}',
            child: CachedNetworkImage(
              imageUrl: playlistInfo.imageUrl,
              placeholder: (context, url) => Container(
                height: 263,
                width: 263,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) => Container(
                height: 263,
                width: 263,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4).copyWith(top: 8),
            child: Text(
              playlistInfo.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                letterSpacing: 0.5,
                fontSize: 22.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
