import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_filter.dart';
import '../widgets/movie_card.dart';
import '../data/dummy_data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Merge all movie lists
    final allMoviesList = [
      ...topBoxOffice,
      ...allMovies,
      ...upcomingTrailersList,
      ...top10IMDbList,
      ...inTheatersList,
      ...fanFavoritesList,
    ];

    // Build categories dynamically
    final List<String> categories = ["All"];
    final Set<String> addedCategories = {};

    for (var movie in allMoviesList) {
      final cat = movie.category?.trim();
      if (cat != null &&
          cat.isNotEmpty &&
          !addedCategories.contains(cat.toLowerCase())) {
        categories.add(cat[0].toUpperCase() + cat.substring(1));
        addedCategories.add(cat.toLowerCase());
      }
    }

    // Filter movies by search query and category
    final filteredMovies = allMoviesList.where((movie) {
      final titleMatches =
      movie.title.toLowerCase().contains(query.toLowerCase());
      final categoryMatches = selectedCategory.toLowerCase() == "all"
          ? true
          : movie.category?.toLowerCase() ==
          selectedCategory.toLowerCase();
      return titleMatches && categoryMatches;
    }).toList();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.background,
            theme.colorScheme.surface.withOpacity(0.25),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // Back button
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),

                const SizedBox(height: 10),

                // Title
                Text("Search", style: theme.textTheme.displayMedium),

                const SizedBox(height: 20),

                // Search bar
                MovieSearchBar(
                  onChanged: (value) => setState(() => query = value),
                  onClear: () => setState(() => query = ""),
                ),

                const SizedBox(height: 20),

                // Category filter
                CategoryFilter(
                  categories: categories,
                  selectedCategory: selectedCategory,
                  onCategorySelected: (cat) =>
                      setState(() => selectedCategory = cat),
                ),

                const SizedBox(height: 20),

                // Movies grid
                Expanded(
                  child: filteredMovies.isEmpty
                      ? Center(
                    child: Text(
                      "No movies found",
                      style: theme.textTheme.bodyLarge,
                    ),
                  )
                      : GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 columns
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.65, // width / height ratio
                    ),
                    itemCount: filteredMovies.length,
                    itemBuilder: (context, index) {
                      final movie = filteredMovies[index];
                      return MovieCard(
                        title: movie.title,
                        rating: movie.rating,
                        image: movie.image,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
