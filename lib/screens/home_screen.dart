import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchMovieTitle = TextEditingController();
  Future<MovieModel?>? _movieFuture;

  Future<MovieModel?> fetchMovieInfo(String movieTitle) async {
    String apiKey = "b2ad6a7f";
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
                // expandedHeight: 50,
                pinned: true,
                floating: true,
                title: SizedBox(
                  height: 40,
                  child: SearchBar(
                    controller: _searchMovieTitle,
                    onChanged: (value) {}, // optional: debounce if you want
                    onSubmitted: (value) => _searchMovie(),
                    backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.onSecondaryFixedVariant,
                    ),
                    hintText: 'Search a movie',
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
                ? const Center(child: Text("Search for a movie above"))
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
                      return const Center(child: Text('Movie not found'));
                    }

                    final movie = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        top: 8,
                        right: 8,
                        bottom: 20,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 350,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(movie.poster),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 18),
                                children: [
                                  const TextSpan(
                                    text: "• Title: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: movie.title),
                                ],
                              ),
                            ),

                            const SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 18),
                                children: [
                                  const TextSpan(
                                    text: "• Year: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: movie.year),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 18),
                                children: [
                                  const TextSpan(
                                    text: "• Rated: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: movie.rated),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 18),
                                children: [
                                  const TextSpan(
                                    text: "• Released: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: movie.released),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 18),
                                children: [
                                  const TextSpan(
                                    text: "• Runtime: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: movie.runtime),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 18),
                                children: [
                                  const TextSpan(
                                    text: "• Genre: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: movie.genre),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 18),
                                children: [
                                  const TextSpan(
                                    text: "• Director: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: movie.director),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 18),
                                children: [
                                  const TextSpan(
                                    text: "• Writer: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: movie.writer),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 18),
                                children: [
                                  const TextSpan(
                                    text: "• Actors: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: movie.actors),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 18),
                                children: [
                                  const TextSpan(
                                    text: "• Plot: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: movie.plot),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 18),
                                children: [
                                  const TextSpan(
                                    text: "• Country: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: movie.country),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 18),
                                children: [
                                  const TextSpan(
                                    text: "• Awards: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: movie.awards),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 18),
                                children: [
                                  const TextSpan(
                                    text: "• IMDb Rating: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: movie.imdbRating),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 18),
                                children: [
                                  const TextSpan(
                                    text: "• Rotten Tomatoes Rating: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: movie.rottenTomatoesRating),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 18),
                                children: [
                                  const TextSpan(
                                    text: "• Box Office: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: movie.boxOffice),
                                ],
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
