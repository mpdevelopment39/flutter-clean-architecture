import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/injector.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/entities/actor.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/local_storage_repository.dart';
import 'notifiers/actors_notifier.dart';
import 'notifiers/movie_map_notifier.dart';
import 'notifiers/movies_notifier.dart';
import 'notifiers/search_notifier.dart';
import 'notifiers/storage_movies_notifier.dart';

//* Storage providers
final favoriteMoviesProvider = StateNotifierProvider<StorageMoviesNotifier,Map<int,Movie>>((ref) {
  return StorageMoviesNotifier();
});

//* Actors providers
final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  return ActorsByMovieNotifier();
});

//* Search providers
final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  return SearchedMoviesNotifier(ref: ref);
});

final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int movieId) {
  return injector<LocalStorageRepository>().isMovieFavorite(movieId);
});

//* Movies providers
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl();
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
  return MovieMapNotifier();
});

final moviesBlockbustersProvider = Provider<List<Movie>>((ref){
  List<Movie> nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];
  nowPlayingMovies = nowPlayingMovies.reversed.toList();
  return nowPlayingMovies.sublist(0,6);
});