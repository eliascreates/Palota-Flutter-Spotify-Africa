import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_africa_assessment/debug.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/data/datasource/spotify_remote_datasource.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/data/repositories/spotify_repository_impl.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
//* FEATURES
  //? Spotify

  //Usecases
  sl.registerLazySingleton(() => GetCategoryById(sl()));
  sl.registerLazySingleton(() => GetAllCategoryPlaylists(sl()));
  sl.registerLazySingleton(() => GetArtistById(sl()));
  sl.registerLazySingleton(() => GetPlaylistById(sl()));

  //Repositories
  sl.registerLazySingleton<SpotifyRepository>(
    () => SpotifyRepositoryImpl(remoteDataSource: sl()),
  );

  //Data Sources
  sl.registerLazySingleton<SpotifyRemoteDataSource>(
    () => SpotifyRemoteDataSourceImpl(client: sl()),
  );

  //? EXTERNAL
  sl.registerLazySingleton(() => http.Client());

  //*Uncomment the line below to see useful logs about any bloc in the terminal.
  // Bloc.observer = PalotaSpotifyObserver();
}
