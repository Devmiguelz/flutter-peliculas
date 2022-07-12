import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:peliculas/models/movie.dart';

class CardSwiper extends StatelessWidget {
  
  final List<Movie> movieList;

  const CardSwiper({super.key, required this.movieList});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    if(movieList.isEmpty) {
      return Container(
        height: screenSize.height * 0.25,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
        width: double.infinity,
        height: screenSize.height * 0.5,
        child: Swiper(
          itemCount: movieList.length,
          layout: SwiperLayout.STACK,
          itemWidth: screenSize.width * 0.5,
          itemHeight: screenSize.height * 0.4,
          itemBuilder: (BuildContext context, int index) {

            final movie = movieList[index];

            movie.heroId = 'swiper-${movie.id}';

            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
              child: Hero(
                tag: movie.heroId!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                      placeholder: const AssetImage('assets/no-image.jpg'),
                      fit: BoxFit.cover,
                      image: NetworkImage(movie.posterUrl)
                    ),
                ),
              ),
            );
          },
        ));
  }
}
