import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/injector.dart';
import '../../../domain/entities/actor.dart';
import '../../../domain/repositories/actors_repository.dart';

class ActorsByMovieNotifier extends StateNotifier<Map<String,List<Actor>>> {
  ActorsByMovieNotifier(): super({});
  
  final ActorsRepository _actorsRepository = injector<ActorsRepository>();

  Future<void> loadActors(String movieId) async {
    if(state[movieId] != null) return;
    final List<Actor> actors = await _actorsRepository.getActorsByMovie(movieId);
    state = {...state, movieId: actors};
  }
}