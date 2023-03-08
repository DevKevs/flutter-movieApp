import 'package:flutter/material.dart';

import '../models/models.dart';

class SearchResult extends StatelessWidget {
  final List<Movie> movies;
  const SearchResult({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 7, top: 5),
      child: SizedBox(
        child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            final movie = movies[index];
            return _MovieItem(
              movie: movie,
              size: size,
              textTheme: textTheme,
              heroId: '${movie.title}-${movie.id}-search',
            );
          },
        ),
      ),
    );
  }
}

class _MovieItem extends StatelessWidget {
  const _MovieItem({
    Key? key,
    required this.movie,
    required this.size,
    required this.textTheme,
    required this.heroId,
  }) : super(key: key);

  final Movie movie;
  final Size size;
  final TextTheme textTheme;
  final String heroId;

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('lib/assets/no-image.jpg'),
          image: NetworkImage(movie.fullPosterPath),
          fit: BoxFit.contain,
          height: 100,
          width: 40,
        ),
      ),
      title: Text(
        movie.title,
        style: textTheme.headline6,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      subtitle: Text(
        movie.originalTitle,
        style: textTheme.subtitle1,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
    );
    // return GestureDetector(
    //   onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 3),
    //     child: Row(
    //       children: [
    //         ClipRRect(
    //           borderRadius: BorderRadius.circular(10),
    //           child: FadeInImage(
    //             placeholder: const AssetImage('lib/assets/no-image.jpg'),
    //             image: NetworkImage(movie.fullPosterPath),
    //             fit: BoxFit.cover,
    //             height: 100,
    //             width: 60,
    //           ),
    //         ),
    //         const SizedBox(
    //           width: 10,
    //         ),
    //         ConstrainedBox(
    //           constraints: BoxConstraints(maxWidth: size.width - 110),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 movie.title,
    //                 style: textTheme.subtitle1,
    //                 overflow: TextOverflow.ellipsis,
    //                 maxLines: 2,
    //               ),
    //               Row(
    //                 children: [
    //                   const Icon(
    //                     Icons.star_border_outlined,
    //                     size: 15,
    //                     color: Colors.grey,
    //                   ),
    //                   const SizedBox(
    //                     width: 5,
    //                   ),
    //                   Text(
    //                     movie.voteAverage.toString(),
    //                     style: textTheme.caption,
    //                   )
    //                 ],
    //               )
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
