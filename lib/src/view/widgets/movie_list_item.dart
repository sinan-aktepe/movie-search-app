import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_app/src/logic/bloc/detail/movie_detail_bloc.dart';
import 'package:movie_search_app/src/logic/model/movie.dart';
import 'package:movie_search_app/src/view/screens/detail_screen.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem({required this.movie, Key? key}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MovieDetailBloc>().add(GetMovieDetails(movie.id!));
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen(movie: movie)));
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .3,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: movie.posterPath != null
                          ? FadeInImage(
                              imageErrorBuilder: (context, error, stackTrace) {
                                return const Center(child: Icon(Icons.error));
                              },
                              fadeInDuration: const Duration(milliseconds: 200),
                              fit: BoxFit.cover,
                              placeholderFit: BoxFit.cover,
                              placeholder: const AssetImage("assets/movie.png"),
                              image: NetworkImage(
                                "https://image.tmdb.org/t/p/original${movie.posterPath}",
                              ),
                            )
                          : Image.asset(
                              "assets/movie.png",
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                      bottom: 5,
                      left: 5,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const CircleAvatar(
                              backgroundColor: Colors.black, radius: 20),
                          CircularProgressIndicator.adaptive(
                            value: movie.voteAverage / 10.0,
                            valueColor:  AlwaysStoppedAnimation<Color>(
                                movie.voteAverage > 7.5 ? Colors.green : movie.voteAverage > 4.0 ? Colors.orange : Colors.red),
                          ),
                          Text("${movie.voteAverage}",
                              style: const TextStyle(color: Colors.white))
                        ],
                      ))
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ]),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: Text(
                movie.originalTitle!,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
