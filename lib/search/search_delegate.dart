import 'package:flutter/material.dart';
import 'package:movie_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/movie_provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search Movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox(
        child: Center(
            child: Icon(
      Icons.movie_creation_outlined,
      color: Colors.black45,
      size: 125,
    )));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Widget _emptyContainer() {
      return const SizedBox(
          child: Center(
              child: Icon(
        Icons.movie_creation_outlined,
        color: Colors.black45,
        size: 125,
      )));
    }

    if (query.isEmpty) {
      return _emptyContainer();
    }
    final moviesProvider = Provider.of<MovieProvider>(context, listen: false);
    moviesProvider.getQueryResults(query);
    return StreamBuilder(
      stream: moviesProvider.movieStream,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();
        return SearchResult(
          movies: snapshot.data!,
        );
      },
    );
  }
}
