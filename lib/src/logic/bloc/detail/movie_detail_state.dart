part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class DetailsLoaded extends MovieDetailState {
  final MovieDetail detail;

  DetailsLoaded(this.detail);
}

class DetailsErrorState extends MovieDetailState {}
