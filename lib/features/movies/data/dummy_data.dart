class DummyMovie {
  final String title;
  final double rating;
  final String image;
  final String? category;

  DummyMovie({
    required this.title,
    required this.rating,
    required this.image,
    this.category ,
  });
}

final List<DummyMovie> topBoxOffice = [
  DummyMovie(title: "Cosmic Journey", rating: 4.8, image: "",category: "action"),
  DummyMovie(title: "Neon City", rating: 4.5, image: ""),
];

final List<DummyMovie> allMovies = [
  DummyMovie(title: "Lost Dreams", rating: 4.2, image: "",category: "action"),
  DummyMovie(title: "Dark Waters", rating: 4.0, image: "",category: "action"),
];
// IMAGES MUST BE PLACED IN /assets/images/


final categories = [
  "Action",
  "Drama",
  "Comedy",
  "Sci-Fi",
  "Thriller",
];

final upcomingTrailersList = [
  DummyMovie(title: "Dune: Part 3", rating: 0, image: ""),
  DummyMovie(title: "The Batman 2", rating: 0, image: ""),
  DummyMovie(title: "Avengers: Secret Wars", rating: 0, image: ""),
];

final top10IMDbList = [
  DummyMovie(title: "The Shawshank Redemption", rating: 9.3, image: ""),
  DummyMovie(title: "The Godfather", rating: 9.2, image: ""),
  DummyMovie(title: "The Dark Knight", rating: 9.0, image: ""),
  DummyMovie(title: "Fight Club", rating: 8.8, image: ""),
];

final inTheatersList = [
  DummyMovie(title: "Joker: Folie à Deux", rating: 8.1, image: ""),
  DummyMovie(title: "Deadpool 3", rating: 8.4, image: ""),
  DummyMovie(title: "Wicked", rating: 7.2, image: ""),
];

final fanFavoritesList = [
  DummyMovie(title: "Interstellar", rating: 8.6, image: ""),
  DummyMovie(title: "Inception", rating: 8.8, image: ""),
  DummyMovie(title: "Avatar", rating: 7.8, image: ""),
];





