
import 'package:flutter_clean_architecture_demo/app/injector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/repositories/local_storage_repository.dart';

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  StorageMoviesNotifier(): super({});

  int page = 0;
  final LocalStorageRepository _localStorageRepository = injector<LocalStorageRepository>();

  Future<List<Movie>> loadNextPage() async {
    final movies = await _localStorageRepository.loadMovies(offset: page * 10, limit: 20);
    page++;
    
    final tempMoviesMap = <int, Movie>{};
    for(final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};
    return movies;
  }

  Future<void> toggleFavorite(Movie movie ) async { 
    await _localStorageRepository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if(isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
    }else{
      state = {...state, movie.id: movie};
    }
  }
}