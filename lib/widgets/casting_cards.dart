import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCard extends StatelessWidget {

  final int movieId;

  const CastingCard({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
        future: moviesProvider.getMovieCast(movieId),
        builder: (context, AsyncSnapshot<List<Cast>> snapshot) {

          if (!snapshot.hasData) {
            return Container(
              height: 100,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final movieCast = snapshot.data;

          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            width: double.infinity,
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieCast!.length,
              itemBuilder: (BuildContext context, int index) {
                return _CastCard(cast: movieCast[index]);
              },
            ),
          );
        }
    );
  }
}

class _CastCard extends StatelessWidget {

  final Cast cast;

  const _CastCard({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(cast.profilePathUrl),
              fit: BoxFit.cover,
              width: 100,
              height: 140,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            cast.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )

        ],

      ),
    );
  }
}