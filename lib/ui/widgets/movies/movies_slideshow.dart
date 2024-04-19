import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_clean_architecture_demo/app/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../../app/constants.dart';
import '../../../domain/entities/movie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoviesBlockbusters extends StatelessWidget {
  final List<Movie> movies;
  
  const MoviesBlockbusters({super.key,required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left:10.0,bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(AppLocalizations.of(context)!.title_blockbusters,style: Theme.of(context).textTheme.titleLarge)),
        ),
        SizedBox(
          height: 200,
          width: double.infinity,
          child: Swiper(
            viewportFraction: 0.8,
            scale: 0.9,
            autoplay: true,
            pagination: SwiperPagination(
              margin: const EdgeInsets.only(top: 0),
              builder: DotSwiperPaginationBuilder(
                activeColor: AppTheme.colorScheme.tertiary,
                color: AppTheme.colorScheme.tertiaryContainer,
                size: 8,
                activeSize: 12
              )
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) => _Item(movie: movies[index]),
          ),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final Movie movie;

  const _Item({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/home/0/movie/${movie.id}'),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: AppTheme.kMoviesBlackLight,
                blurRadius: 10,
                offset: Offset(0, 10)
              )
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              movie.backdropPath,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if(loadingProgress != null) {
                  return Center(
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: Lottie.asset('$assetsAnimations/movie_loading.json')));
                }
                return FadeIn(child: child);
              },
            )
          )
        ),
      ),
    );
  }
}
