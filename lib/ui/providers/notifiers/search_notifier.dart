import 'package:flutter_clean_architecture_demo/app/injector.dart';
import 'package:flutter_clean_architecture_demo/domain/managers/movies_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/movie.dart';
import '../providers.dart';

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  SearchedMoviesNotifier({required this.ref}): super([]);

  final Ref ref;
  final MoviesManager _moviesManager = injector<MoviesManager>();

  Future<List<Movie>> searchMoviesByQuery(String query) async{
    final List<Movie> movies = await _moviesManager.searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;
    return movies;
  }
}