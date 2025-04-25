class MovieModel {
  const MovieModel({
    required this.poster,
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.country,
    required this.awards,
    required this.imdbRating,
    required this.rottenTomatoesRating,
    required this.boxOffice,
  });

  final String poster;
  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String country;
  final String awards;
  final String imdbRating;
  final String rottenTomatoesRating;
  final String boxOffice;

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      poster: json['Poster'] ?? '',
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      rated: json['Rated'] ?? '',
      released: json['Released'] ?? '',
      runtime: json['Runtime'] ?? '',
      genre: json['Genre'] ?? '',
      director: json['Director'] ?? '',
      writer: json['Writer'] ?? '',
      actors: json['Actors'] ?? '',
      plot: json['Plot'] ?? '',
      country: json['Country'] ?? '',
      awards: json['Awards'] ?? '',
      imdbRating: json['imdbRating'] ?? '',
      rottenTomatoesRating: json['Ratings'][1]['Value'] ?? '',
      boxOffice: json['BoxOffice'] ?? '',
    );
  }
}
