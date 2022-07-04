part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchMovie extends SearchEvent {
  final String query;

  SearchMovie(this.query);
}

class LoadMovies extends SearchEvent {
  final SearchResult searchResult;
  final String keyword;

  LoadMovies(this.searchResult, this.keyword);
}

class LoadMore extends SearchEvent {
  final String query;

  LoadMore(this.query);
}

class SearchErrorEvent extends SearchEvent {}

class ClearSearch extends SearchEvent {}

