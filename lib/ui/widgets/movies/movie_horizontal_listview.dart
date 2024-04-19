import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_clean_architecture_demo/app/constants.dart';
import 'package:flutter_clean_architecture_demo/app/helpers.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../../app/theme.dart';
import '../../../domain/entities/movie.dart';


class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.loadNextPage
  });

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(widget.loadNextPage == null) return;
      if((scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if(widget.title != null) Padding(
            padding: const EdgeInsets.only(left:10.0,bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.title!, style: Theme.of(context).textTheme.titleLarge)),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(child: _Item(movie: widget.movies[index]));
              },
            )
          )
        ],
      ),
    );
  }
}


class _Item extends StatelessWidget {
  final Movie movie;

  const _Item({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            height: 220,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress != null) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Lottie.asset('$assetsAnimations/movie_loading.json')),
                    );
                  }
                  return GestureDetector(
                    onTap: () => context.push('/home/0/movie/${movie.id}'),
                    child: FadeIn(child: child),
                  );
                  
                },
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 150,
            height: 40,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyles.titleSmall,
            ),
          ),
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: AppTheme.kMoviesYellow),
                const SizedBox(width: 3),
                Text(movie.voteAverage.toStringAsFixed(1), style: textStyles.bodyMedium?.copyWith(color: AppTheme.kMoviesYellow)),
                const Spacer(),
                Text(Helpers.formatNumber(movie.popularity), style: textStyles.bodySmall),
              ],
            ),
          )
        ],
      ),
    );
  }
}


