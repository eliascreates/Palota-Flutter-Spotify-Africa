import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';
import 'service_locator.dart' as di;
import 'theme.dart';

Future<void> main() async {
  await di.init();
  runApp(const PalotaAssessmentApp());
}

class PalotaAssessmentApp extends StatelessWidget {
  const PalotaAssessmentApp({Key? key}) : super(key: key);

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
