import 'package:flutter/material.dart';

//Used in both Category page and Playlist Page

//Shows up under the event that the api request fails to load Data
class ShowErrorMessage extends StatelessWidget {
  const ShowErrorMessage({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Text(message),
      ),
    );
  }
}