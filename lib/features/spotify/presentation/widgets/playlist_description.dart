import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';

class PlaylistDescription extends StatelessWidget {
  const PlaylistDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final text = context.select(
      (SpotifyPlaylistCubit cubit) => cubit.state.playlist.description,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AnimatedOpacity(
        opacity: text.isEmpty ? 0 : 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        child: SizedBox(
          height: 35,
          child: Text(
            text,
            overflow: TextOverflow.clip,
            maxLines: 2,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}
