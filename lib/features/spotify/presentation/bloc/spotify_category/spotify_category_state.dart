part of 'spotify_category_bloc.dart';

enum CategoryStatus { initial, loading, success, failure }

class SpotifyCategoryState extends Equatable {
  const SpotifyCategoryState({
    this.pageNumber = 0,
    this.paginatedPlaylist,
    this.status = CategoryStatus.initial,
    this.errorMessage,
  });
  final int pageNumber;
  final PaginatedPlaylist? paginatedPlaylist;
  final CategoryStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        pageNumber,
        paginatedPlaylist,
        status,
        errorMessage,
      ];
}
