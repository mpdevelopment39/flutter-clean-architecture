import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_demo/app/dio_movies.dart';
import '../../app/injector.dart';
import '../../domain/datasources/actors_datasource.dart';
import '../../domain/entities/actor.dart';
import '../mappers/actor_mapper.dart';
import '../models/moviedb/credits_response.dart';

class ActorMovieDbDatasource extends ActorsDatasource {

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async{
    Response response = await injector<DioMovies>().dio.get('/movie/$movieId/credits');
    CreditsResponse castResponse = CreditsResponse.fromJson(response.data);
    return castResponse.cast.map((cast) => ActorMapper.castToEntity(cast)).toList();
  }

}