import 'package:movie_search_app/src/logic/model/movie_detail.dart';

import '../model/search_result.dart';

abstract class MovieRepository {
  const MovieRepository(this.apiKey);

  final String apiKey;

  Future<SearchResult> searchMovies(String query, int page);

  Future<MovieDetail> getMovieDetails(int id);
}
