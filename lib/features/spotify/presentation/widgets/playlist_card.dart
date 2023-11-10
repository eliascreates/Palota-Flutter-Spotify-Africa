import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaylistCard extends StatelessWidget {
  final String imageUrl;
  final String playlistName;

  const PlaylistCard({
    super.key,
    required this.onPress,
    required this.imageUrl,
    required this.playlistName,

    //Default sizes for category playlist
    this.imageSize = 155,
    this.imageRadius = 8,
    this.containerRadius = 12,
    this.containerPadding = 4,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w500,
    this.textPadding = 4,
  });

  final VoidCallback onPress;

  final double imageSize;
  final double imageRadius;
  final FontWeight fontWeight;
  final double containerRadius;
  final double containerPadding;
  final double fontSize;
  final double textPadding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(containerPadding),
        decoration: BoxDecoration(
          color: const Color(0xFF211F26),
          borderRadius: BorderRadius.circular(containerRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   decoration: BoxDecoration(boxShadow: [
            //     BoxShadow(
            //       blurRadius: 4,
            //       color: Colors.black.withOpacity(0.25),
            //       offset: const Offset(0, 4),
            //     )
            //   ]),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(imageRadius),
            //     child: Image.network(
            //       imageUrl,
            //       height: imageSize,
            //       width: imageSize,
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            // ),
            CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => Container(
                height: 155,
                width: 155,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.0),
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
                height: 155,
                width: 155,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
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
            Padding(
              padding: const EdgeInsets.all(4).copyWith(top: 8),
              child: Text(
                playlistName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  letterSpacing: 0.5,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
