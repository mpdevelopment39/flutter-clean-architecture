import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_demo/app/constants.dart';
import 'package:flutter_clean_architecture_demo/app/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import '../../providers/providers.dart';
import '../../widgets/movies/movies_gridview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if(isLoading || isLastPage) return;
    isLoading = true;
    final movies = await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if(movies.isEmpty) isLastPage = true;
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if(favoriteMovies.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 70.w,
                height: 70.w,
                child: SvgPicture.asset('$assetsImages/no_images.svg')),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.no_favorites,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: AppTheme.colorScheme.primary)),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      body: MoviesGridView(
        movies: favoriteMovies,
        loadNextPage: loadNextPage,
      )
    );
  }
}