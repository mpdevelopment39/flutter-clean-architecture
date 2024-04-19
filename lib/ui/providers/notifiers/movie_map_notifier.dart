import 'package:flutter_clean_architecture_demo/app/injector.dart';
import 'package:flutter_clean_architecture_demo/domain/managers/movies_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/movie.dart';

class MovieMapNotifier extends StateNotifier<Map<String,Movie>> {
  MovieMapNotifier(): super({});

  final MoviesManager _moviesManager = injector<MoviesManager>();

  Future<void> getMovieById(String movieId) async {
    if(state[movieId] != null) return;
    final movie = await _moviesManager.getMovieById(movieId);
    state = {...state, movieId: movie};
  }
}