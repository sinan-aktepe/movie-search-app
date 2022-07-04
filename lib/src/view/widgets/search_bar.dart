import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_app/src/logic/bloc/search/search_bloc.dart';

class SearchBar extends StatefulWidget {
  const SearchBar(this.controller, {Key? key}) : super(key: key);

  final TextEditingController controller;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      builder: ((context, state) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          padding: const EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: TextField(
                  controller: widget.controller,
                  onChanged: (value) {
                    if (value.length > 2) {
                      context.read<SearchBloc>().add(SearchMovie(value));
                    }

                    if (value.isEmpty || value.length <= 2) {
                      context.read<SearchBloc>().add(ClearSearch());
                    }
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "type a movie name...",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: IconButton(
                        onPressed: () {
                          context.read<SearchBloc>().add(ClearSearch());
                          widget.controller.clear();
                        },
                        icon: const Icon(Icons.clear),
                      )),
                ),
              ),
            ],
          ),
        );
      }),
      listener: (context, state) {
        if (state is MoviesLoaded &&
            state.lastFetchedQuery != widget.controller.text) {
          context.read<SearchBloc>().add(SearchMovie(widget.controller.text));
        }
      },
    );
  }
}
