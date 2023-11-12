import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/spotify.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';
import 'service_locator.dart' as di;
import 'config/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  await di.init();
  runApp(const PalotaAssessmentApp());
}

class PalotaAssessmentApp extends StatelessWidget {
  const PalotaAssessmentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpotifyPlaylistCubit(
        getArtistById: di.sl<GetArtistById>(),
        getPlaylistById: di.sl<GetPlaylistById>(),
      ),
      child: const PalotaAssessmentAppView(),
    );
  }
}

class PalotaAssessmentAppView extends StatelessWidget {
  const PalotaAssessmentAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Palota Spotify Africa Assessment',
      theme: palotaLightTheme,
      darkTheme: palotaDarkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: AppRoutes.startUp,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
