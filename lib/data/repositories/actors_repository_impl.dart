import 'package:dio/dio.dart';
import '../../app/dio_movies.dart';
import '../../app/injector.dart';
import '../../domain/entities/actor.dart';
import '../../domain/repositories/actors_repository.dart';
import '../mappers/actor_mapper.dart';
import '../models/moviedb/credits_response.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  final Dio _dio = injector<DioMovies>().dio;
  
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    Response response = await _dio.get('/movie/$movieId/credits');
    CreditsResponse castResponse = CreditsResponse.fromJson(response.data);
    return castResponse.cast.map((cast) => ActorMapper.castToEntity(cast)).toList();
  }

}