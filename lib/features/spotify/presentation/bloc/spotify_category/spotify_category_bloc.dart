import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/domain/domain.dart';
import 'package:stream_transform/stream_transform.dart';

part 'spotify_category_event.dart';
part 'spotify_category_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (event, mapper) {
    return droppable<E>().call(event.throttle(duration), mapper);
  };
}

class SpotifyCategoryBloc
    extends Bloc<SpotifyCategoryEvent, SpotifyCategoryState> {
  SpotifyCategoryBloc() : super(const SpotifyCategoryState()) {
    on<SpotifyCategoryEvent>((event, emit) {
      // TODO: implement event handler
    }, transformer: throttleDroppable(const Duration(milliseconds: 100)));

    on<SpotifyCategoryPlaylistsFetched>((event, emit) {});
  }
}
