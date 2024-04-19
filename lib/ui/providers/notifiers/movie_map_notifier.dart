import 'package:flutter_clean_architecture_demo/app/injector.dart';
import 'package:flutter_clean_architecture_demo/domain/repositories/movies_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/movie.dart';

class MovieMapNotifier extends StateNotifier<Map<String,Movie>> {
  MovieMapNotifier(): super({});

  final MoviesRepository _moviesRepository = injector<MoviesRepository>();

  Future<void> loadMovie(String movieId) async {
    if(state[movieId] != null) return;
    final movie = await _moviesRepository.getMovieById(movieId);
    state = {...state, movieId: movie};
  }
}