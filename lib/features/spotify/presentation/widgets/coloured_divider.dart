
import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';

class ColouredDivider extends StatelessWidget {
  const ColouredDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 4,
        width: 326,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              AppColors.blue,
              AppColors.cyan,
              AppColors.green,
            ],
          ),
        ),
      ),
    );
  }
}
