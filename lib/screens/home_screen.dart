import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movie_app/widgets/widgets.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:movie_app/search/search_delegate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MovieProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('KEVFLIX'),
          actions: [
            IconButton(
                onPressed: () => showSearch(
                    context: context, delegate: MovieSearchDelegate()),
                icon: const Icon(Icons.search))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CardSwiper(movies: moviesProvider.onDisplayMovies),
              MovieSlider(
                movies: moviesProvider.popularMovies,
                widgetTitle: 'Trending Topic',
                onNextPage: () => moviesProvider.getPopularMovies(),
              ),
            ],
          ),
        ));
  }
}
