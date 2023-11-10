part of 'spotify_bloc.dart';

abstract class SpotifyCategoryEvent extends Equatable {
  const SpotifyCategoryEvent();

  @override
  List<Object> get props => [];
}

class SpotifyCategoryFetchedById extends SpotifyCategoryEvent {
  final String categoryId;

  const SpotifyCategoryFetchedById({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class SpotifyCategoryPlaylistsFetched extends SpotifyCategoryEvent {
  final String categoryId;

  const SpotifyCategoryPlaylistsFetched({
    required this.categoryId,
  });

  @override
  List<Object> get props => [categoryId];
}
