import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/helpers/debouncer.dart';
import 'package:movie_app/models/models.dart';
import 'dart:convert' as convert;

import 'package:movie_app/models/search_response.dart';

class MovieProvider extends ChangeNotifier {
  final String _apiKey = '556b628683590e6e72e82b13d6ccc375';
  final String _baseUrl = 'api.themoviedb.org';
  final String _leng = 'en-US';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  // List<Movie> searchResponse = [];
  Map<int, List<Cast>> movieCast = {};
  int _popularPage = 0;

  final debouncer = Debouncer(duration: const Duration(milliseconds: 400));

  final StreamController<List<Movie>> _streamController =
      StreamController.broadcast();
  Stream<List<Movie>> get movieStream => _streamController.stream;

  MovieProvider() {
    // ignore: avoid_print
    print('Powered by Movie provider!');
    getNowPlayingMovies();
    getPopularMovies();
  }

  getNowPlayingMovies() async {
    final response = await _apiGetCall('3/movie/now_playing');
    if (response.statusCode == 200) {
      final jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      final nowPlayingResponse = NowPlaying.fromJson(jsonResponse);
      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();
      // print(nowPlayingResponse.results[2].title);
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  getPopularMovies() async {
    _popularPage++;
    final response = await _apiGetCall('3/movie/popular', _popularPage);

    if (response.statusCode == 200) {
      final jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      final popularMoviesResponse = PopularMovies.fromJson(jsonResponse);
      popularMovies = [...popularMovies, ...popularMoviesResponse.results];
      notifyListeners();
      // print(nowPlayingResponse.results[2].title);
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<List<Cast>> getCasting(int movieId) async {
    final response = await _apiGetCall('3/movie/$movieId/credits');
    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;
    final jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    final castResponse = CastResponse.fromJson(jsonResponse);
    movieCast[movieId] = castResponse.cast;
    return castResponse.cast;
  }

  _apiGetCall(String segment, [int page = 1]) async {
    final url = Uri.https(_baseUrl, segment,
        {'api_key': _apiKey, 'language': _leng, 'page': '$page'});

    final response = await http.get(url);

    return response;
  }

  Future<List<Movie>> searchMovies(String query, [int page = 1]) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _leng,
      'page': '$page',
      'query': query
    });

    final response = await http.get(url);

    final jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    final srcResponse = SearchResponse.fromJson(jsonResponse);

    return srcResponse.results;
  }

  void getQueryResults(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchMovies(value);

      _streamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
