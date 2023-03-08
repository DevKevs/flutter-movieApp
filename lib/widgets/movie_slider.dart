import 'package:flutter/material.dart';
import 'package:movie_app/theme/theme.dart';

import '../models/models.dart';

class MovieSlider extends StatefulWidget {
  const MovieSlider(
      {super.key,
      required this.movies,
      this.widgetTitle,
      required this.onNextPage});
  final List<Movie> movies;
  final String? widgetTitle;
  final Function onNextPage;

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) {
      return const SizedBox(
        width: double.infinity,
        height: 260,
        child: Center(
            child: CircularProgressIndicator(
          color: AppTheme.primary,
        )),
      );
    }
    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.widgetTitle != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.widgetTitle!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(
            height: 7,
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (context, index) => _MovieRowPoster(
                  movie: widget.movies[index],
                  heroId:
                      '${widget.widgetTitle}-$index-${widget.movies[0].id}'),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieRowPoster extends StatelessWidget {
  const _MovieRowPoster({
    Key? key,
    required this.movie,
    required this.heroId,
  }) : super(key: key);
  final Movie movie;
  final String heroId;

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: heroId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('lib/assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterPath),
                  height: 190,
                  width: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
