import 'package:flutter_clean_architecture_demo/app/helpers.dart';
import 'package:flutter_clean_architecture_demo/data/repositories/actors_repository_impl.dart';
import 'package:flutter_clean_architecture_demo/data/repositories/local_storage_repository_impl.dart';
import 'package:flutter_clean_architecture_demo/data/repositories/movie_repository_impl.dart';
import 'package:flutter_clean_architecture_demo/domain/managers/local_storage_manager.dart';
import 'package:flutter_clean_architecture_demo/domain/managers/movies_manager.dart';
import 'package:flutter_clean_architecture_demo/domain/repositories/actors_repository.dart';
import 'package:flutter_clean_architecture_demo/domain/repositories/local_storage_repository.dart';
import 'package:flutter_clean_architecture_demo/domain/repositories/movies_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../domain/entities/movie.dart';
import '../domain/managers/actors_manager.dart';
import 'dio_movies.dart';

//* Clase para gestionar la inyección de dependencias del proyecto
final GetIt injector = GetIt.instance;

class Injector {
  Injector(){
    injector.allowReassignment = true;    
    injector.registerSingletonAsync<Isar>(() async {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [MovieSchema], 
        inspector: true,directory: dir.path
      );
    });
    injector.registerSingleton<DioMovies>(DioMovies());
    injector.registerLazySingleton<Helpers>(() => Helpers());
    
    //* MANAGERS
    injector.registerLazySingleton<ActorsManager>(() => ActorsManager());
    injector.registerLazySingleton<LocalStorageManager>(() => LocalStorageManager());
    injector.registerLazySingleton<MoviesManager>(() => MoviesManager());
    
    //* REPOSITORIES
    injector.registerLazySingleton<ActorsRepository>(() => ActorsRepositoryImpl());
    injector.registerLazySingleton<LocalStorageRepository>(() => LocalStorageRepositoryImpl());
    injector.registerLazySingleton<MoviesRepository>(() => MovieRepositoryImpl());
  }
}


