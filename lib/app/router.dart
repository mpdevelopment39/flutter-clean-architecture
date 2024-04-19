import 'package:flutter_clean_architecture_demo/ui/pages/home_page.dart';
import 'package:flutter_clean_architecture_demo/ui/pages/movie_page.dart';
import 'package:go_router/go_router.dart';

//* Clase para gestionar las diferentes rutas del proyecto a la hora de navegar entre pantallas
final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:page',
      name: HomePage.name,
      builder: (_, state) => HomePage(pageIndex: int.parse(state.pathParameters['page'] ?? '0')),
      routes: [
         GoRoute(
          path: 'movie/:id',
          name: MoviePage.name,
          builder: (_, state) => MoviePage(movieId: state.pathParameters['id'] ?? 'no-id'),
        ),
      ]
    ),
    GoRoute(
      path: '/',
      redirect: ( _ , __ ) => '/home/0',
    ),
  ]
);
