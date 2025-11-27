import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_filter.dart';
import '../widgets/section_list.dart';
import '../data/dummy_data.dart';
import '../widgets/movie_caroussel.dart';
import './search_page.dart'; // <<< you must import this

class MoviesHomePage extends StatelessWidget {
  const MoviesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text("Movies", style: theme.textTheme.displayMedium),
              const SizedBox(height: 4),
              Text(
                "Discover your next favorite",
                style: theme.textTheme.bodyMedium,
              ),

              const SizedBox(height: 20),

              // Search bar → Tap to open SearchPage
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SearchPage(),
                    ),
                  );
                },
                child: AbsorbPointer(
                  child: const MovieSearchBar(),
                ),
              ),

              const SizedBox(height: 20),

              // Category filter




              // Trailer Carousel
              const TrailerCarousel(),

              const SizedBox(height: 30),

              // Horizontal scrolling lists
              SectionList(title: "Top 10 IMDb", movies: top10IMDbList),
              const SizedBox(height: 20),
              SectionList(title: "In Theaters Near You", movies: inTheatersList),
              const SizedBox(height: 20),
              SectionList(title: "Fan Favorites", movies: fanFavoritesList),

              const SizedBox(height: 30),

              // Box Office vertical list
              SectionList(title: "Box Office", movies: topBoxOffice),
            ],
          ),
        ),
      ),

      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.search), label: "Search"),
          NavigationDestination(icon: Icon(Icons.bookmark), label: "Wishlist"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
        ],
        selectedIndex: 0,
      ),
    );
  }
}
