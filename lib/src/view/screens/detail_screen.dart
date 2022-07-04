import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_search_app/src/logic/bloc/detail/movie_detail_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_app/src/logic/model/movie.dart';
import '../../utils/app_utils.dart' as utils;

class DetailScreen extends StatefulWidget {
  const DetailScreen({required this.movie, Key? key}) : super(key: key);

  final Movie movie;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Future<bool> _onWillPop() async {
    context.read<MovieDetailBloc>().add(ClearDetial());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Text(widget.movie.title!),
        ),
        body: SafeArea(
          child: BlocConsumer<MovieDetailBloc, MovieDetailState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: utils.getDetailBackdrop(state),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(.7)),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 15,
                    right: 15,
                    bottom: 15,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .35,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(.4),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                          offset: const Offset(.2, .6))
                                    ]),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: widget.movie.getMoviePoster),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircleAvatar(
                                            backgroundColor:
                                                Colors.black.withOpacity(.5),
                                            radius: 50),
                                        SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 10,
                                            value:
                                                widget.movie.voteAverage / 10.0,
                                            valueColor: AlwaysStoppedAnimation<
                                                Color>(widget
                                                        .movie.voteAverage >
                                                    7.5
                                                ? Colors.green
                                                : widget.movie.voteAverage > 4.0
                                                    ? Colors.orange
                                                    : Colors.red),
                                          ),
                                        ),
                                        Text(
                                          "${widget.movie.voteAverage}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "OVERVIEW",
                            style: TextStyle(
                              color: Colors.white.withOpacity(.7),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          state is DetailsLoaded
                              ? Text(
                                  state.detail.overview != null
                                      ? state.detail.overview!
                                      : "Nothing here to show",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(.7),
                                  ),
                                )
                              : state is DetailsErrorState
                                  ? const Text("Something went wrong")
                                  : const LinearProgressIndicator(),
                          const SizedBox(height: 10),
                          Text(
                            "GENRES",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(.7),
                            ),
                          ),
                          state is DetailsLoaded
                              ? SizedBox(
                                  height: 60,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.detail.genres!.length,
                                    itemBuilder: (context, index) {
                                      final list = state.detail.genres;
                                      if (list == null || list.isEmpty) {
                                        return const Text(
                                            "Nothing here to show");
                                      }

                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Chip(
                                            label: Text(
                                          list[index].name!,
                                          style: const TextStyle(
                                              color: Colors.red),
                                        )),
                                      );
                                    },
                                  ),
                                )
                              : state is DetailsErrorState
                                  ? const Text("Something went wrong")
                                  : const LinearProgressIndicator(),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
