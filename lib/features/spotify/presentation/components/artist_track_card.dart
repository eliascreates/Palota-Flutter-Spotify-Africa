import 'package:flutter/material.dart';


class ArtistTrackCard extends StatelessWidget {
  const ArtistTrackCard({
    super.key,
    required this.imageUrl,
    required this.artistName,
    required this.songName,
    required this.duration,
  });

  final String imageUrl;
  final String artistName;
  final String songName;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              imageUrl,
              width: 48,
              height: 48,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                songName,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: 12,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                artistName,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 11,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Expanded(
            child: Text(
              duration,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}
