import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_outlined),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if (query.isEmpty) {
      return Container(
        child: const Center(
          child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 100),
        ),
      );
    }

    final moviesProvider = Provider.of<MoviesProvider>(context);

    moviesProvider.searchByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.stream_movie,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {

        if (!snapshot.hasData) {
          return Container(
            height: 100,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final movies = snapshot.data;

        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return _MovieItem(movie: movies![index]);
          },
        );
      },
    );

  }

}

class _MovieItem extends StatelessWidget {

  final Movie movie;

  const _MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'searchba-${movie.id}';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          image: NetworkImage(movie.posterUrl),
          placeholder: const AssetImage('assets/no-image.jpg'),
          fit: BoxFit.contain,
          height: 100,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}