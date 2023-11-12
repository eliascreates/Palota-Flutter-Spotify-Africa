import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/config/routes/routes.dart';
import 'package:flutter_spotify_africa_assessment/service_locator.dart';

import '../../domain/domain.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class SpotifyCategoryPage extends StatelessWidget {
  final String categoryId;

  const SpotifyCategoryPage({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpotifyBloc(
        getCategoryById: sl<GetCategoryById>(),
        getAllCategoryPlaylists: sl<GetAllCategoryPlaylists>(),
      )
        ..add(SpotifyCategoryFetchedById(categoryId: categoryId))
        ..add(SpotifyCategoryPlaylistsFetched(categoryId: categoryId)),
      child: SpotifyCategoryView(categoryId: categoryId),
    );
  }
}

class SpotifyCategoryView extends StatelessWidget {
  const SpotifyCategoryView({super.key, required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(categoryId[0].toUpperCase() + categoryId.substring(1)),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.about),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.blue, AppColors.cyan, AppColors.green],
            ),
          ),
        ),
      ),
      body: BlocBuilder<SpotifyBloc, SpotifyCategoryState>(
        builder: (context, state) {
          if (state.status == CategoryStatus.loading &&
              state.playlists.isEmpty) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator(color: AppColors.cyan)),
              ],
            );
          }

          if (state.status == CategoryStatus.failure &&
              state.errorMessage != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('${state.errorMessage}')),
              ],
            );
          }
          return CategoryPlaylistBody(categoryId: categoryId);
        },
      ),
    );
  }
}
