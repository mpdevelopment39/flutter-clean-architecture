import 'package:isar/isar.dart';
import '../../app/injector.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/local_storage_repository.dart';


class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final Isar _isar = injector<Isar>();

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final Movie? isFavoriteMovie = await _isar.movies
      .filter()
      .idEqualTo(movieId)
      .findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    return injector<Isar>().movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final favoriteMovie = await _isar.movies
      .filter()
      .idEqualTo(movie.id)
      .findFirst();

    if(favoriteMovie != null) {
      _isar.writeTxnSync(() => _isar.movies.deleteSync( favoriteMovie.isarId! ));
      return;
    }

    _isar.writeTxnSync(() => _isar.movies.putSync(movie));
  }

}
