import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_clean_architecture_demo/app/helpers.dart';
import 'package:sizer/sizer.dart';
import '../../app/injector.dart';
import '../../app/theme.dart';
import '../../domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

//* Clase para gestionar el delegate de busqueda de películas
class SearchMovieDelegate extends SearchDelegate<Movie?>{
  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;
  
  SearchMovieDelegate({required this.searchMovies,required this.initialMovies}):super();

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;

  void clearStreams() {
    debouncedMovies.close();
  }

  void _onQueryChanged( String query ) {
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query);
      initialMovies = movies;
      debouncedMovies.add(movies);
      isLoadingStream.add(false);
    });

  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            onMovieSelected: (context, movie) {
              clearStreams();
              close(context, movie);
            },
          ),
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if(snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 10),
              spins: 10,
              infinite: true,
              child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(Icons.refresh_rounded)
              ),
            );
          }
          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = '',
              icon: const Icon(Icons.clear)
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }

}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie,required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: 20.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 70.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: Theme.of(context).textTheme.titleMedium),
                  (movie.overview.length > 100)
                    ? Text('${movie.overview.substring(0,100)}...')
                    : Text(movie.overview),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded, color: AppTheme.kMoviesYellow),
                      const SizedBox(width: 5),
                      Text(
                        injector<Helpers>().formatNumber(movie.voteAverage, 1),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppTheme.kMoviesYellow),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}