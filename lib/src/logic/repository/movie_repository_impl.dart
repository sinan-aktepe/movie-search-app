import 'dart:convert';

import 'package:movie_search_app/src/logic/model/movie_detail.dart';
import 'package:movie_search_app/src/logic/model/search_result.dart';
import 'package:movie_search_app/src/logic/repository/movie_repository.dart';
import 'package:http/http.dart' as http;

class MovieRepositoryImpl extends MovieRepository {
  MovieRepositoryImpl(super.apiKey);

  @override
  Future<SearchResult> searchMovies(String query, int page) async {
    final res = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/search/movie?api_key=$apiKey&language=en-US&query=$query&page=$page&include_adult=false"),
    );

    if (res.statusCode != 200) {
      return SearchResult(
        movies: [],
        page: -1,
        totalPages: -1,
        totalResults: -1,
      );
    } else {
      return SearchResult.fromMap(json.decode(res.body));
    }
  }

  @override
  Future<MovieDetail> getMovieDetails(int id) async {
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/$id?api_key=$apiKey&language=en-US"));

    if (res.statusCode != 200) {
      return MovieDetail(id: -1);
    } else {
      return MovieDetail.fromJson(json.decode(res.body));
    }
  }
}
