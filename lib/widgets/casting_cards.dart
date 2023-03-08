import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/providers/movie_provider.dart';

import '../models/models.dart';

class CastingCards extends StatelessWidget {
  const CastingCards({super.key, required this.movieId});
  final int movieId;

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MovieProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getCasting(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            child: const CupertinoActivityIndicator(),
          );
        }
        final cast = snapshot.data!;
        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
              itemBuilder: (_, int index) => _CastCards(actor: cast[index])),
        );
      },
    );
  }
}

class _CastCards extends StatelessWidget {
  const _CastCards({required this.actor});
  final Cast actor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('lib/assets/no-image.jpg'),
              image: NetworkImage(actor.fullprofilePath),
              fit: BoxFit.cover,
              height: 140,
              width: 100,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
