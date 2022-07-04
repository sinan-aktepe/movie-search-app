import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../model/movie_detail.dart';
import '../../repository/movie_repository_impl.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final respository = MovieRepositoryImpl("493b049c6e95ea188f32fe9042a3565f");

  MovieDetailBloc() : super(MovieDetailInitial()) {
    on<GetMovieDetails>(_onGetMovieDetails);

    on<ClearDetial>(_onClearDetail);
  }

  _onGetMovieDetails(GetMovieDetails event, emit) async {
    final detail = await respository.getMovieDetails(event.id);
    if (detail.id == -1) {
      emit(DetailsErrorState());
    } else {
      emit(DetailsLoaded(detail));
    }
  }

  _onClearDetail(ClearDetial event, emit) {
    emit(MovieDetailInitial());
  }
}
