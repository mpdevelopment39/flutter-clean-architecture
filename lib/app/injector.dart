import 'package:flutter_clean_architecture_demo/app/helpers.dart';
import 'package:flutter_clean_architecture_demo/data/datasources/actor_moviedb_datasource.dart';
import 'package:flutter_clean_architecture_demo/data/datasources/isar_datasource.dart';
import 'package:flutter_clean_architecture_demo/data/datasources/moviedb_datasource.dart';
import 'package:flutter_clean_architecture_demo/data/repositories/actor_repository_impl.dart';
import 'package:flutter_clean_architecture_demo/data/repositories/local_storage_repository_impl.dart';
import 'package:flutter_clean_architecture_demo/data/repositories/movie_repository_impl.dart';
import 'package:flutter_clean_architecture_demo/domain/repositories/actors_repository.dart';
import 'package:flutter_clean_architecture_demo/domain/repositories/local_storage_repository.dart';
import 'package:flutter_clean_architecture_demo/domain/repositories/movies_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import '../domain/entities/movie.dart';
import 'dio_movies.dart';

//* Clase para gestionar la inyección de dependencias del proyecto
final GetIt injector = GetIt.instance;

class Injector {
  Injector(){
    injector.allowReassignment = true;
    injector.registerLazySingleton<Logger>(() => Logger(printer: PrettyPrinter(
      methodCount: 2, 
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    )));
    
    injector.registerSingletonAsync<Isar>(() async {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [MovieSchema], 
        inspector: true,directory: dir.path
      );
    });
    injector.registerSingleton<DioMovies>(DioMovies());
    injector.registerLazySingleton<Helpers>(() => Helpers());
    
    //* DATASOURCES
    injector.registerSingleton<ActorMovieDbDatasource>(ActorMovieDbDatasource());
    injector.registerSingleton<IsarDatasource>(IsarDatasource());
    injector.registerSingleton<MoviedbDatasource>(MoviedbDatasource());

    //* REPOSITORIES
    injector.registerLazySingleton<ActorsRepository>(() => ActorRepositoryImpl(ActorMovieDbDatasource()));
    injector.registerLazySingleton<LocalStorageRepository>(() => LocalStorageRepositoryImpl(IsarDatasource()));
    injector.registerLazySingleton<MoviesRepository>(() => MovieRepositoryImpl(MoviedbDatasource()));
  }
}


