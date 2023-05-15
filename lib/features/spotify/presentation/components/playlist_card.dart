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
  });

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFF211F26),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(0, 4))
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  height: 155,
                  width: 155,
                  fit: BoxFit.fill,
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
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
