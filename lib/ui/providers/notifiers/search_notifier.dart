
import 'package:flutter_clean_architecture_demo/app/injector.dart';
import 'package:flutter_clean_architecture_demo/domain/repositories/movies_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../providers.dart';

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  SearchedMoviesNotifier({required this.ref}): super([]);

  final Ref ref;
  final MoviesRepository _moviesRepository = injector<MoviesRepository>();

  Future<List<Movie>> searchMoviesByQuery(String query) async{
    final List<Movie> movies = await _moviesRepository.searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = movies;
    return movies;
  }
}