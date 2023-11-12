import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import 'category_header.dart';
import 'category_playlist_list.dart';

class CategoryPlaylistBody extends StatefulWidget {
  const CategoryPlaylistBody({super.key, required this.categoryId});

  final String categoryId;

  @override
  State<CategoryPlaylistBody> createState() => _CategoryPlaylistBodyState();
}

class _CategoryPlaylistBodyState extends State<CategoryPlaylistBody> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,

      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              BlocBuilder<SpotifyBloc, SpotifyCategoryState>(
                builder: (context, state) {
                  return CategoryHeader(
                    imageUrl: state.category.imageUrl,
                    categoryName: widget.categoryId,
                  );
                },
              ),
            ],
          ),
        ),
        CategoryPlaylistList(_scrollController,
            categoryId: widget.categoryId),
      ],
    );
  }
}
