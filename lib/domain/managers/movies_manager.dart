import 'package:flutter_clean_architecture_demo/domain/repositories/movies_repository.dart';
import '../../app/injector.dart';
import '../entities/movie.dart';

class MoviesManager {
  final MoviesRepository _moviesRepository = injector<MoviesRepository>();
  
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    return await _moviesRepository.getNowPlaying(page: page);
  }

  Future<List<Movie>> getPopular({int page = 1}) async {
    return await _moviesRepository.getPopular(page: page);
  }

  Future<List<Movie>> getTopRated({int page = 1}) async {
    return await _moviesRepository.getTopRated(page: page);
  }

  Future<List<Movie>> getUpcoming({int page = 1}) async {
    return await _moviesRepository.getUpcoming(page: page);
  }

  Future<Movie> getMovieById(String id) async {
    return await _moviesRepository.getMovieById(id);
  }

  Future<List<Movie>> searchMovies(String query) async {
    return await _moviesRepository.searchMovies(query);
  }
}