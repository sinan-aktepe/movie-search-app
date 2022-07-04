import 'package:flutter/material.dart';
import 'package:movie_search_app/src/logic/model/movie.dart';
import '../logic/bloc/detail/movie_detail_bloc.dart';

extension MovieExtension on Movie {
  Image get getMoviePoster {
    return posterPath != null
        ? Image.network(
            "https://image.tmdb.org/t/p/original$posterPath",
            fit: BoxFit.cover,
          )
        : Image.asset(
            "assets/movie.png",
            fit: BoxFit.cover,
          );
  }
}

Widget getDetailBackdrop(MovieDetailState state) {
  return state is DetailsLoaded && state.detail.backdropPath != null
      ? Image.network(
          "https://image.tmdb.org/t/p/original${state.detail.backdropPath}",
          fit: BoxFit.cover,
        )
      : Image.asset(
          "assets/movie.png",
          fit: BoxFit.cover,
        );
}

TextStyle detailBodyStyle() => TextStyle(
      color: Colors.white.withOpacity(.7),
    );
