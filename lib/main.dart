import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_app/src/logic/bloc/detail/movie_detail_bloc.dart';
import 'package:movie_search_app/src/logic/bloc/search/search_bloc.dart';
import 'package:movie_search_app/src/view/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: ((context) => MovieDetailBloc())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            titleSpacing: 0,
            elevation: 0,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
