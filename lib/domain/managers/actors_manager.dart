import '../../app/injector.dart';
import '../entities/actor.dart';
import '../repositories/actors_repository.dart';

class ActorsManager {
  final ActorsRepository _actorsRepository = injector<ActorsRepository>();
  
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    return await _actorsRepository.getActorsByMovie(movieId);
  }
}