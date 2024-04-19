import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../widgets/movies/movie_horizontal_listview.dart';
import '../../widgets/movies/movies_slideshow.dart';
import '../../widgets/shared/custom_appbar.dart';
import '../../widgets/shared/full_screen_loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    if(ref.watch(initialLoadingProvider)) return const FullScreenLoading();
    
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: CustomAppbar(),
        ),
        SliverList(delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              MoviesBlockbusters(movies: ref.watch(moviesBlockbustersProvider)),
              MovieHorizontalListview(
                movies: ref.watch(nowPlayingMoviesProvider),
                title: AppLocalizations.of(context)!.in_cinemas_title,
                loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()
              ),
              MovieHorizontalListview(
                movies: ref.watch(upcomingMoviesProvider),
                title: AppLocalizations.of(context)!.coming_soon_title,
                loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage()
              ),
              MovieHorizontalListview(
                movies: ref.watch(popularMoviesProvider),
                title: AppLocalizations.of(context)!.coming_soon_title,
                loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage()
              ),
              MovieHorizontalListview(
                movies: ref.watch(topRatedMoviesProvider),
                title: AppLocalizations.of(context)!.top_rated_title,
                loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage()
              ),
              const SizedBox(height: 10),
            ]);
          },
          childCount: 1
        )),
      ]
    );
  }
}