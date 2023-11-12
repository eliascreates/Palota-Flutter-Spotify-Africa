import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';

const robotoFont = 'Roboto';

const backgroundColor = Color(0xFF141218);
const onBackgroundColor = Color(0xFF211F26);

final palotaDarkTheme = ThemeData(
  fontFamily: robotoFont,

  colorScheme: ColorScheme.fromSeed(
    background: backgroundColor,
    onBackground: onBackgroundColor,
    brightness: Brightness.dark,
    seedColor: AppColors.cyan,
  ),
  useMaterial3: true,
);

final palotaLightTheme = palotaDarkTheme;
