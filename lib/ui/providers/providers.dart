import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/injector.dart';
import '../../data/datasources/actor_moviedb_datasource.dart';
import '../../data/datasources/isar_datasource.dart';
import '../../data/datasources/moviedb_datasource.dart';
import '../../data/repositories/actor_repository_impl.dart';
import '../../data/repositories/local_storage_repository_impl.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/entities/actor.dart';
import '../../domain/entities/movie.dart';
import 'notifiers/actors_notifier.dart';
import 'notifiers/movie_map_notifier.dart';
import 'notifiers/movies_notifier.dart';
import 'notifiers/search_notifier.dart';
import 'notifiers/storage_movies_notifier.dart';

//* Storage providers

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(injector<IsarDatasource>());
});

final favoriteMoviesProvider = StateNotifierProvider<StorageMoviesNotifier,Map<int,Movie>>((ref) {
  return StorageMoviesNotifier(localStorageRepository: ref.watch(localStorageRepositoryProvider));
});

//* Actors providers

final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(injector<ActorMovieDbDatasource>());
});

final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  return ActorsByMovieNotifier(getActors: ref.watch(actorsRepositoryProvider).getActorsByMovie);
});

//* Search providers

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  return SearchedMoviesNotifier(searchMovies: ref.read(movieRepositoryProvider).searchMovies,ref: ref);
});

final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int movieId) {
  return ref.watch(localStorageRepositoryProvider).isMovieFavorite(movieId);
});

//* Movies providers

final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(injector<MoviedbDatasource>());
});

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  return MoviesNotifier(fetchMoreMovies: ref.watch(movieRepositoryProvider).getNowPlaying);
});

final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  return MoviesNotifier(fetchMoreMovies: ref.watch(movieRepositoryProvider).getPopular);
});

final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  return MoviesNotifier(fetchMoreMovies: ref.watch(movieRepositoryProvider).getUpcoming);
});

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  return MoviesNotifier(fetchMoreMovies: ref.watch(movieRepositoryProvider).getTopRated);
});

final initialLoadingProvider = Provider<bool>((ref) {

  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final step2 = ref.watch(popularMoviesProvider).isEmpty;
  final step3 = ref.watch(topRatedMoviesProvider).isEmpty;
  final step4 = ref.watch(upcomingMoviesProvider).isEmpty;

  if( step1 || step2 || step3 || step4 ) return true;

  return false;
});

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  return MovieMapNotifier(getMovie: ref.watch(movieRepositoryProvider).getMovieById);
});

final moviesBlockbustersProvider = Provider<List<Movie>>((ref){
  final List<Movie> nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];
  nowPlayingMovies.shuffle();
  return nowPlayingMovies.sublist(0,6);
});