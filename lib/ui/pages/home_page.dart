import 'package:flutter/material.dart';
import '../views/movies/favorites_view.dart';
import '../views/movies/home_view.dart';
import '../widgets/shared/custom_bottom_navigation.dart';

//* Clase para gestionar la UI de la Página principal con las 2 vistas de películas y favoritos
class HomePage extends StatelessWidget {
  static const name = 'home-screen';
  final int pageIndex;

  const HomePage({super.key,required this.pageIndex});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: const [
          HomeView(),
          FavoritesView(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex),
    );
  }
}