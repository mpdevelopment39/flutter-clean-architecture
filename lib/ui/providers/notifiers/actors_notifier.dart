import 'package:flutter_clean_architecture_demo/domain/managers/actors_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/injector.dart';
import '../../../domain/entities/actor.dart';

class ActorsByMovieNotifier extends StateNotifier<Map<String,List<Actor>>> {
  ActorsByMovieNotifier(): super({});
  
  final ActorsManager _actorsManager = injector<ActorsManager>();

  Future<void> getActorsByMovie(String movieId) async {
    if(state[movieId] != null) return;
    final List<Actor> actors = await _actorsManager.getActorsByMovie(movieId);
    state = {...state, movieId: actors};
  }
}