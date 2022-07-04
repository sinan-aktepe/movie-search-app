import 'package:movie_search_app/src/logic/bloc/detail/movie_detail_bloc.dart';
import 'package:movie_search_app/src/logic/bloc/search/search_bloc.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('SearchBloc', () {
    late SearchBloc searchBloc;

    setUp(() {
      searchBloc = SearchBloc();
    });

    test('initial state is MoviesInitial', () {
      expect(searchBloc.state.runtimeType, MoviesInitial);
    });

    blocTest(
      'After search, loading and loaded states are emitted',
      build: () => SearchBloc(),
      act: (SearchBloc bloc) => bloc.add(SearchMovie("avengers")),
      wait: const Duration(seconds: 1),
      expect: () => [isA<MoviesLoading>(), isA<MoviesLoaded>()],
    );

    blocTest(
      'After load more, loaded state is emitted',
      build: () => SearchBloc(),
      act: (SearchBloc bloc) => bloc.add(LoadMore("avengers")),
      wait: const Duration(seconds: 1),
      expect: () => [isA<MoviesLoaded>()],
    );

    blocTest(
      'After clear search, the state should be initial',
      build: () => SearchBloc(),
      act: (SearchBloc bloc) => bloc.add(ClearSearch()),
      expect: () => [isA<MoviesInitial>()],
    );
  });

  group('MovieDetailBloc', () {
    late MovieDetailBloc detailBloc;

    setUp(() {
      detailBloc = MovieDetailBloc();
    });

    test('initial state is MovieDetailInitial', () {
      expect(detailBloc.state.runtimeType, MovieDetailInitial);
    });

    blocTest(
      'Details success while fetching an existing id',
      build: () => MovieDetailBloc(),
      act: (MovieDetailBloc bloc) => bloc.add(GetMovieDetails(-454247)),
      wait: const Duration(seconds: 1),
      expect: () => [isA<DetailsErrorState>()],
    );

    blocTest(
      'Details error while fetching wrong id',
      build: () => MovieDetailBloc(),
      act: (MovieDetailBloc bloc) => bloc.add(GetMovieDetails(1726)),
      wait: const Duration(seconds: 1),
      expect: () => [isA<DetailsLoaded>()],
    );

    blocTest(
      'When details are cleared, the state should be initial',
      build: () => MovieDetailBloc(),
      act: (MovieDetailBloc bloc) => bloc.add(ClearDetial()),
      expect: () => [isA<MovieDetailInitial>()],
    );
  });
}
