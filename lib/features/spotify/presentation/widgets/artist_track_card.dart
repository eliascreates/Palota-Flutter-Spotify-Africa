import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArtistTrackTile extends StatelessWidget {
  const ArtistTrackTile({
    super.key,
    required this.imageUrl,
    required this.artistName,
    required this.songName,
    required this.duration,
  });

  final String imageUrl;
  final String artistName;
  final String songName;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) => Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  songName,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 12,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w500),
                ),
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
              formatDuration(duration),
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

    //Some songs like LoFi music can be over 60 minutes long
  String formatDuration(Duration duration) {
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    if (duration.inMinutes > 60) {
      return "$hours:$minutes:$seconds";
    }

    return "$minutes:$seconds";
  }
}
