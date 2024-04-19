import 'package:isar/isar.dart';
import '../../app/injector.dart';
import '../../domain/datasources/local_storage_datasource.dart';
import '../../domain/entities/movie.dart';

class IsarDatasource extends LocalStorageDatasource {
  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final Movie? isFavoriteMovie = await injector<Isar>().movies
      .filter()
      .idEqualTo(movieId)
      .findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final favoriteMovie = await injector<Isar>().movies
      .filter()
      .idEqualTo(movie.id)
      .findFirst();

    if ( favoriteMovie != null ) {
      injector<Isar>().writeTxnSync(() => injector<Isar>().movies.deleteSync( favoriteMovie.isarId! ));
      return;
    }

    injector<Isar>().writeTxnSync(() => injector<Isar>().movies.putSync(movie));
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    return injector<Isar>().movies.where()
      .offset(offset)
      .limit(limit)
      .findAll();
  }

}