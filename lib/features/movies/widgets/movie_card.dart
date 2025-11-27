import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final double rating;
  final String? image; // Optional image URL

  const MovieCard({
    super.key,
    required this.title,
    required this.rating,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Placeholder widget
    Widget placeholder(double height) {
      return Container(
        height: height,
        width: double.infinity,
        color: theme.colorScheme.surfaceVariant,
        child: const Icon(
          Icons.movie,
          size: 60,
          color: Colors.grey,
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Make the image take ~60% of available height
        final imageHeight = constraints.maxHeight * 0.6;

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.surface,
                theme.colorScheme.background.withOpacity(0.1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movie poster
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: (image != null && image!.isNotEmpty)
                    ? Image.asset(
                  image!,
                  height: imageHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      placeholder(imageHeight),
                )
                    : placeholder(imageHeight),
              ),

              // Title and rating
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 6),
                          Text(
                            rating.toStringAsFixed(1),
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
