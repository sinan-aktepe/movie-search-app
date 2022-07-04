part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class MoviesInitial extends SearchState {}

class MoviesLoading extends SearchState {}

class MoviesLoaded extends SearchState {
  final List<Movie?> movies;
  final bool hasReachedMax;
  final String lastFetchedQuery;

  MoviesLoaded(
    this.movies,
    this.hasReachedMax,
    this.lastFetchedQuery,
  );
}

class MoviesErrorState extends SearchState {}
