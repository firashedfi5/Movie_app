import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/widgets/info_row.dart';
import 'package:movie_app/widgets/rating_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchMovieTitle = TextEditingController();
  Future<MovieModel?>? _movieFuture;

  Future<MovieModel?> fetchMovieInfo(String movieTitle) async {
    await dotenv.load(fileName: ".env");

    String? apiKey = dotenv.env['apiKey'];
    final url = Uri.parse(
      "http://www.omdbapi.com/?apikey=$apiKey&t=$movieTitle",
    );
    final response = await http.get(url);

    dev.log(response.body.toString());

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Response'] == 'True') {
        return MovieModel.fromJson(data);
      } else {
        dev.log('Movie not found: ${data['Error']}');
      }
    } else {
      dev.log('Failed to load data: ${response.statusCode}');
    }
    return null;
  }

  void _searchMovie() {
    setState(() {
      _movieFuture = fetchMovieInfo(_searchMovieTitle.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverAppBar(
                expandedHeight: 65,
                pinned: true,
                floating: true,
                title: SizedBox(
                  height: 45,
                  child: SearchBar(
                    controller: _searchMovieTitle,
                    onChanged: (value) {},
                    onSubmitted: (value) => _searchMovie(),
                    backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.onSecondaryFixedVariant,
                    ),
                    hintText: 'Search for a movie title...',
                    leading: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
        body:
            _movieFuture == null
                ? Center(
                  child: Text(
                    "Search for a movie above",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                )
                : FutureBuilder<MovieModel?>(
                  future: _movieFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || snapshot.data == null) {
                      return Center(
                        child: Text(
                          'Movie not found',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      );
                    }

                    final movie = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                height: 450,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.2,
                                      ),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    movie.poster,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: Theme.of(context).dividerColor,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    InfoRow(label: "Title", value: movie.title),
                                    const Divider(),
                                    InfoRow(label: "Year", value: movie.year),
                                    const Divider(),
                                    InfoRow(label: "Rated", value: movie.rated),
                                    const Divider(),
                                    InfoRow(
                                      label: "Runtime",
                                      value: movie.runtime,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: Theme.of(context).dividerColor,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Plot Summary",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      movie.plot,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: RatingCard(
                                    title: "IMDb",
                                    value: movie.imdbRating,
                                    icon: Icons.star,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: RatingCard(
                                    title: "Rotten Tomatoes",
                                    value: movie.rottenTomatoesRating,
                                    icon: Icons.local_movies,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: Theme.of(context).dividerColor,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    InfoRow(
                                      label: "Director",
                                      value: movie.director,
                                    ),
                                    const Divider(),
                                    InfoRow(
                                      label: "Writer",
                                      value: movie.writer,
                                    ),
                                    const Divider(),
                                    InfoRow(
                                      label: "Actors",
                                      value: movie.actors,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: Theme.of(context).dividerColor,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    InfoRow(
                                      label: "Box Office",
                                      value: movie.boxOffice,
                                    ),
                                    const Divider(),
                                    InfoRow(
                                      label: "Awards",
                                      value: movie.awards,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
