import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/bloc/bloc.dart';
import 'package:intl/intl.dart';

class PlaylistFollowers extends StatelessWidget {
  const PlaylistFollowers({super.key});

  @override
  Widget build(BuildContext context) {
    final total = context.select(
      (SpotifyPlaylistCubit cubit) => cubit.state.playlist.totalFollowers,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 195,
          padding: const EdgeInsets.symmetric(vertical: 8).copyWith(right: 16),
          decoration: const BoxDecoration(
            color: Color(0xFF211F26),
            borderRadius:
                BorderRadiusDirectional.horizontal(start: Radius.circular(12)),
          ),
          child: AnimatedOpacity(
            opacity: total == 0 ? 0 : 1,
            duration: const Duration(seconds: 1),
            child: Text(
              formatNumFollowers(total),
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    fontSize: 11,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  String formatNumFollowers(int? numFollowers) {
    var thousandSeparator = NumberFormat("#,###,000");
    if (numFollowers != null) {
      return "${thousandSeparator.format(numFollowers)} Followers";
    }

    return "No Followers yet";
  }
}
