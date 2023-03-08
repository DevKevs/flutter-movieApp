import 'models.dart';
import 'dart:convert';

class PopularMovies {
  PopularMovies({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory PopularMovies.fromRawJson(String str) =>
      PopularMovies.fromJson(json.decode(str));

  factory PopularMovies.fromJson(Map<String, dynamic> json) => PopularMovies(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
