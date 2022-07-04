part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailEvent {}

class GetMovieDetails extends MovieDetailEvent {
  final int id;

  GetMovieDetails(this.id);
}

class ClearDetial extends MovieDetailEvent {}
