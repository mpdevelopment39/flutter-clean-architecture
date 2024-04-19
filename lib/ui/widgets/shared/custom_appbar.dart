import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_demo/app/theme.dart';
import 'package:flutter_clean_architecture_demo/ui/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/movie.dart';
import '../../delegates/search_movie_delegate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.movie_sharp, color: AppTheme.colorScheme.primary),
              const Spacer(),
              Text(AppLocalizations.of(context)!.app_name, style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showSearch<Movie?>(
                    query: ref.read(searchQueryProvider),
                    context: context,
                    delegate: SearchMovieDelegate(
                      initialMovies: ref.read(searchedMoviesProvider),
                      searchMovies: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery
                    )
                  ).then((movie) {
                    if(movie == null) return;
                    context.push('/home/0/movie/${movie.id}');
                  });
                },
                icon: const Icon(Icons.search)
              ),
            ],
          ),
        ),
      )
    );
  }
}