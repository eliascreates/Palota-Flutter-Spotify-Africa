import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({
    super.key,
    required this.imageUrl,
    required this.artistName,
  });

  final String imageUrl;
  final String artistName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 32),
      child: Column(
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(32),
          //   child: Image.network(
          //     imageUrl,
          //     height: 120,
          //     width: 120,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) => Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.0),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            artistName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5),
          )
        ],
      ),
    );
  }
}
