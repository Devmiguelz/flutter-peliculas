import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/helpers/debouncer.dart';
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = 'b64b03fafe7233edd4892e0b812297ea';
  final String _language = 'es-ES';

  List<Movie> list_movie = [];

  List<Movie> list_movie_popular = [];

  final _debouncer = Debouncer<String>(
    duration: const Duration(milliseconds: 500)
  );

  final StreamController<List<Movie>> _streamController = StreamController.broadcast();

  Stream<List<Movie>> get stream_movie => _streamController.stream;

   Map<int, List<Cast>> list_movie_cast = {};

  int _popularPage = 0;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {

    final url = Uri.https(_baseUrl, endpoint, 
      {
        'api_key': _apiKey, 
        'language': _language, 
        'page': '$page'
      });

    final response = await http.get(url);

    return response.body;
  }

  getOnDisplayMovies() async {

    final jsonData = await _getJsonData('3/movie/now_playing');

    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    list_movie = nowPlayingResponse.results;

    notifyListeners();

  }

  getPopularMovies() async {

    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular', _popularPage);

    final popularResponse = PopularResponse.fromJson(jsonData);

     list_movie_popular = [...list_movie_popular, ...popularResponse.results];

    notifyListeners();

  }

  Future<List<Cast>> getMovieCast(int movieId) async {

    if(list_movie_cast.containsKey(movieId)) {
      return list_movie_cast[movieId]!;
    }

    final jsonData = await _getJsonData('3/movie/$movieId/credits');

    final creditsResponse = CreditsResponse.fromJson(jsonData);

    list_movie_cast[movieId] = creditsResponse.cast; 

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    
    final url = Uri.https(_baseUrl, '3/search/movie',
        {
          'api_key': _apiKey, 
          'language': _language, 
          'query': query
        });

    final response = await http.get(url);

    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void searchByQuery(String searchText) {

    _debouncer.onValue = (value) async {

      final result = await searchMovies(value);

      _streamController.add(result);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) { 
      _debouncer.value = searchText;
    });

    Future.delayed(const Duration(milliseconds: 301), () {
      timer.cancel();
    });
  }
}
