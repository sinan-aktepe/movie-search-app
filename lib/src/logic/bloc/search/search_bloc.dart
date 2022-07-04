import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_search_app/src/logic/model/movie.dart';
import 'package:movie_search_app/src/logic/model/search_result.dart';
import 'package:movie_search_app/src/logic/repository/movie_repository_impl.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  int _page = 0;

  bool isFetching = false;

  final List<Movie?> _movies = [];

  final respository = MovieRepositoryImpl("493b049c6e95ea188f32fe9042a3565f");

  SearchBloc() : super(MoviesInitial()) {
    on<SearchMovie>(_onSearchMovie);

    on<LoadMovies>(_onLoadMovies);

    on<LoadMore>(_onLoadMore);

    on<ClearSearch>(_onClearSearch);

    on<SearchErrorEvent>(_onSearchError);
  }

  _onSearchMovie(SearchMovie event, emit) async {
    if (isFetching) {
      return;
    }

    isFetching = true;
    _movies.clear();
    _page = 1;

    emit(MoviesLoading());

    final searchResult = await respository.searchMovies(event.query, _page);

    if (searchResult.page == -1) {
      add(SearchErrorEvent());
    } else {
      add(LoadMovies(searchResult, event.query));
    }
  }

  _onLoadMovies(LoadMovies event, emit) {
    _movies.addAll(event.searchResult.movies);
    emit(MoviesLoaded(
        _movies, _page >= event.searchResult.totalPages, event.keyword));
    isFetching = false;
    _page++;
  }

  _onClearSearch(ClearSearch event, emit) {
    _clearSearch();
    emit(MoviesInitial());
  }

  _onLoadMore(LoadMore event, emit) async {
    if (isFetching) {
      return;
    }

    isFetching = true;

    final searchResult = await respository.searchMovies(event.query, _page);
    add(LoadMovies(searchResult, event.query));
  }

  _onSearchError(SearchErrorEvent event, emit) {
    emit(MoviesErrorState());
  }

  void _clearSearch() {
    _movies.clear();
    _page = 1;
    isFetching = false;
  }
}
