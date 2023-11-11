import 'package:flutter/material.dart';

const robotoFont = 'Roboto';

final palotaDarkTheme = ThemeData(
  fontFamily: robotoFont,
  scaffoldBackgroundColor: const Color(0xFF141218),
  colorScheme:
      ColorScheme.fromSeed(brightness: Brightness.dark, seedColor: Colors.cyan),
  useMaterial3: true,
);

final palotaLightTheme = palotaDarkTheme;
