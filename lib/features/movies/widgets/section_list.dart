import 'package:flutter/material.dart';
import 'movie_card.dart';
import '../data/dummy_data.dart';

class SectionList extends StatelessWidget {
  final String title;
  final List<DummyMovie> movies;

  const SectionList({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: theme.textTheme.titleMedium),
            Text(
              "See all →",
              style: theme.textTheme.bodySmall!
                  .copyWith(color: theme.colorScheme.primary),
            ),
          ],
        ),

        const SizedBox(height: 16),

        SizedBox(
          height: 280, // total card height (image + text)
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, i) {
              final m = movies[i];
              return SizedBox(
                width: 180, // fixed width for horizontal list
                child: MovieCard(
                  title: m.title,
                  rating: m.rating,
                  image: m.image,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
