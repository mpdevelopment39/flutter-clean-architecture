import 'package:flutter_clean_architecture_demo/domain/repositories/local_storage_repository.dart';
import '../../app/injector.dart';
import '../entities/movie.dart';


class LocalStorageManager {
  final LocalStorageRepository _localStorageRepository = injector<LocalStorageRepository>();

  Future<bool> isMovieFavorite(int movieId) async {
    return _localStorageRepository.isMovieFavorite(movieId);
  }

  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    return _localStorageRepository.loadMovies();
  }

  Future<void> toggleFavorite(Movie movie) async {
    return _localStorageRepository.toggleFavorite(movie);
  }
  
}