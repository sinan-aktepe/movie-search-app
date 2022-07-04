import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_app/src/logic/bloc/search/search_bloc.dart';
import 'package:movie_search_app/src/view/widgets/movie_list_item.dart';

import '../widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffeeeeee),
        body: SafeArea(
          child: Column(
            children: [
              SearchBar(_searchController),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: ((context, state) {
                    if (state is MoviesInitial) {
                      return const Center(
                        child: Text(
                          "I'll bring what you're looking for 😎",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      );
                    }

                    if (state is MoviesLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: CircularProgressIndicator()),
                      );
                    }

                    if (state is MoviesLoaded) {
                      final movies = state.movies;

                      if (movies.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("Nothing related here"),
                          ),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: _scrollController,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150,
                            childAspectRatio: 2 / 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: state.hasReachedMax
                              ? movies.length
                              : movies.length + 1,
                          itemBuilder: (ctx, index) {
                            return index >= movies.length
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : MovieListItem(movie: movies[index]!);
                          },
                        ),
                      );
                    } else {
                      return const Text("something went wrong");
                    }
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Exit App"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            TextButton(onPressed: () => exit(0), child: const Text("Exit")),
          ],
        );
      },
    );
    return false;
  }

  void _onScrollListener() {
    if (_isBottom) {
      context.read<SearchBloc>().add(LoadMore(_searchController.text));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScrollListener)
      ..dispose();
    _searchController.dispose();
    super.dispose();
  }
}
