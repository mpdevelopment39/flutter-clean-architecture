import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigation({super.key,required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => context.go('/home/$index'),
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.movie_creation),
          label: AppLocalizations.of(context)!.movies_title
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite_outline),
          label: AppLocalizations.of(context)!.favorites_title
        ),
      ]
    );
  }
}