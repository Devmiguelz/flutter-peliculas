import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/theme/app_theme.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
	 
	const DetailsScreen({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie; 

		return Scaffold(
			body: CustomScrollView(
        slivers: [
          _CustomAppBar(title: movie.title, backdropPath: movie.backdropUrl),

          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie: movie,),
              _OverView(overview: movie.overview),
              _OverView(overview: movie.overview),
              _OverView(overview: movie.overview),
              _OverView(overview: movie.overview),

              CastingCard(movieId: movie.id,)
          ])
          )
        ]
      )
		);
	}
}

class _CustomAppBar extends StatelessWidget {

  final String title;
  final String backdropPath;
  
  const _CustomAppBar({Key? key, required this.title, required this.backdropPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppTheme.primaryColor,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 10),
            color: Colors.black12,
            child: Text(title, 
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
          ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(backdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;

    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [

          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.posterUrl),
                height: 150,
              ),
            ),
          ),

          const SizedBox(width: 10),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: screenSize.width - 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                Text(movie.title, 
                  style: textTheme.headline5, 
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
          
                Text(movie.originalTitle,
                  style: textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
          
                Row(
                  children: [
          
                    const Icon(Icons.star, color: Colors.yellow),
          
                    const SizedBox(width: 5),
          
                    Text(movie.voteAverage.toString(),
                      style: textTheme.caption,
                    ),
          
                  ],
                ),
          
              ],
            ),
          ),

        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {

  final String overview;

  const _OverView({super.key, required this.overview});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}