import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';

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
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final reachedScrollLimit = context.select(
      (SpotifyBloc bloc) => bloc.state.hasReachedScrollLimit,
    );

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
        const CategoryPlaylistList(),
        if (_isBottomOfList && !reachedScrollLimit)
          const SliverToBoxAdapter(
            child:
                Center(child: CircularProgressIndicator(color: AppColors.cyan)),
          ),
      ],
    );
  }

  void _onScroll() {
    if (_isBottomOfList) {
      context.read<SpotifyBloc>().add(
            SpotifyCategoryPlaylistsFetched(
              categoryId: widget.categoryId,
            ),
          );
    }
  }

  bool get _isBottomOfList {
    if (!_scrollController.hasClients) return false;
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    final currentScrollPosition = _scrollController.offset;

    return currentScrollPosition >= maxScrollExtent;
  }
}
