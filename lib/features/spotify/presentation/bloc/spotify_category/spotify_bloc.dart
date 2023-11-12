import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../domain/domain.dart';

part 'spotify_category_event.dart';
part 'spotify_category_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (event, mapper) {
    return droppable<E>().call(event.throttle(duration), mapper);
  };
}

class SpotifyBloc extends Bloc<SpotifyCategoryEvent, SpotifyCategoryState> {
  final GetCategoryById getCategoryById;
  final GetAllCategoryPlaylists getAllCategoryPlaylists;

  SpotifyBloc({
    required this.getCategoryById,
    required this.getAllCategoryPlaylists,
  }) : super(const SpotifyCategoryState()) {
    on<SpotifyCategoryFetchedById>(_onSpotifyCategoryFetchedById);
    on<SpotifyCategoryPlaylistsFetched>(
      _onSpotifyCategoryPlaylistsFetched,
      transformer: throttleDroppable(const Duration(seconds: 1)),
    );
  }

  Future<void> _onSpotifyCategoryFetchedById(
    SpotifyCategoryFetchedById event,
    Emitter<SpotifyCategoryState> emit,
  ) async {
    emit(state.copyWith(status: CategoryStatus.loading, errorMessage: null));

    final result = await getCategoryById(categoryId: event.categoryId);

    emit(
      await result.fold(
        (failureMessage) async => state.copyWith(
          status: CategoryStatus.failure,
          errorMessage: failureMessage,
        ),
        (category) async => state.copyWith(
          category: category,
          status: CategoryStatus.success,
          errorMessage: null,
        ),
      ),
    );
  }

  Future<void> _onSpotifyCategoryPlaylistsFetched(
    SpotifyCategoryPlaylistsFetched event,
    Emitter<SpotifyCategoryState> emit,
  ) async {
    if (state.hasReachedScrollLimit) return;

    emit(state.copyWith(status: CategoryStatus.loading, errorMessage: null));

    final result = await getAllCategoryPlaylists(
      categoryId: event.categoryId,
      pageNumber: state.pageNumber,
    );

    emit(
      await result.fold(
        (failureMessage) async => state.copyWith(
          status: CategoryStatus.failure,
          errorMessage: failureMessage,
        ),
        (playlistPager) async {
          final combinedPlaylists = List.of(state.playlists)
            ..addAll(playlistPager.briefPlaylistInfo);

          final isMaxLimit = (playlistPager.total - playlistPager.limit) <
              playlistPager.offset;

          return state.copyWith(
            playlistPager: playlistPager,
            playlists: combinedPlaylists,
            status: CategoryStatus.success,
            pageNumber: state.pageNumber + 1,
            hasReachedScrollLimit: isMaxLimit,
            errorMessage: null,
          );
        },
      ),
    );
  }
}
