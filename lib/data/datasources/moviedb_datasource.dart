import 'package:dio/dio.dart';
import '../../app/dio_movies.dart';
import '../../app/injector.dart';
import '../../domain/datasources/movies_datasource.dart';
import '../../domain/entities/movie.dart';
import '../mappers/movie_mapper.dart';
import '../models/moviedb/movie_details.dart';
import '../models/moviedb/moviedb_response.dart';


class MoviedbDatasource extends MoviesDatasource {

  List<Movie> _jsonToMovies(Map<String,dynamic> json) {
    final MovieDbResponse movieDBResponse = MovieDbResponse.fromJson(json);
    return movieDBResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster' )
    .map((moviedb) => MovieMapper.movieDBToEntity(moviedb)).toList();
  }


  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final Response response = await injector<DioMovies>().dio.get('/movie/now_playing',
      queryParameters: {'page': page}
    );
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final Response response = await injector<DioMovies>().dio.get('/movie/popular',
      queryParameters: {'page': page}
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final Response response = await injector<DioMovies>().dio.get('/movie/top_rated', 
      queryParameters: {'page': page}
    );
    return _jsonToMovies(response.data);
  }

   @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final Response response = await injector<DioMovies>().dio.get('/movie/upcoming',
      queryParameters: {'page': page}
    );
    return _jsonToMovies(response.data);
  }


  @override
  Future<Movie> getMovieById(String id) async {
    final Response response = await injector<DioMovies>().dio.get('/movie/$id');
    if(response.statusCode != 200) throw DioException(requestOptions: RequestOptions(),message: response.statusMessage);
    final movieDetails = MovieDetails.fromJson( response.data );
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }
  
  @override
  Future<List<Movie>> searchMovies(String query) async{
    if(query.isEmpty) return [];
    final Response response = await injector<DioMovies>().dio.get('/search/movie',
      queryParameters: {'query': query}
    );
    return _jsonToMovies(response.data);
  }

}