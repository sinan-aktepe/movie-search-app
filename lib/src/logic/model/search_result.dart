import 'package:movie_search_app/src/logic/model/movie.dart';

class SearchResult {
  final int page;
  final int totalPages;
  final int totalResults;
  final List<Movie?> movies;

  SearchResult({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.movies,
  });

  factory SearchResult.fromMap(Map<String, dynamic> map) {
    final List list = map['results'];

    return SearchResult(
      page: map['page'],
      totalPages: map['total_pages'],
      totalResults: map['total_results'],
      movies: list.map((e) => Movie.fromJson(e)).toList(),
    );
  }
}
