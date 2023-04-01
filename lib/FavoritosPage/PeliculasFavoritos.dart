import 'package:flutter/material.dart';

import '../settings/settings.dart';

class PeliculasFavoritos extends StatelessWidget {
  const PeliculasFavoritos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30.0),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [bgSecondary_2, bgSecondary],
        begin: FractionalOffset.topCenter,
        end: FractionalOffset.bottomCenter,
        stops: [0.2, 0.8],
      )),
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        mainAxisSpacing: 10.0,
        children: [
          Container(
            width: 88.0,
            height: 130.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                  fit: BoxFit.contain),
            ),
          ),
          Container(
            width: 88.0,
            height: 130.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                  fit: BoxFit.contain),
            ),
          ),
          Container(
            width: 88.0,
            height: 130.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                  fit: BoxFit.contain),
            ),
          ),
          Container(
            width: 88.0,
            height: 130.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                  fit: BoxFit.contain),
            ),
          ),
          Container(
            width: 88.0,
            height: 130.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                  fit: BoxFit.contain),
            ),
          ),
          Container(
            width: 88.0,
            height: 130.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                  fit: BoxFit.contain),
            ),
          ),
          Container(
            width: 88.0,
            height: 130.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                  fit: BoxFit.contain),
            ),
          ),
          Container(
            width: 88.0,
            height: 130.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                  fit: BoxFit.contain),
            ),
          ),
          Container(
            width: 88.0,
            height: 130.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                  fit: BoxFit.contain),
            ),
          ),
          Container(
            width: 88.0,
            height: 130.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                  fit: BoxFit.contain),
            ),
          ),
          Container(
            width: 88.0,
            height: 130.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                  fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }
}
