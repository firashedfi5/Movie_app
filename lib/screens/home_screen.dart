import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/generated/l10n.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/providers/locale_provider.dart';
import 'package:movie_app/widgets/info_row.dart';
import 'package:movie_app/widgets/rating_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
                actions: [
                  Consumer(
                    builder: (context, ref, child) {
                      return IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                title: const Text('Select Language'),
                                children: [
                                  ListTile(
                                    title: const Text('English'),
                                    onTap: () {
                                      ref
                                          .read(localeProvider.notifier)
                                          .state = const Locale('en');
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('العربية'),
                                    onTap: () {
                                      ref
                                          .read(localeProvider.notifier)
                                          .state = const Locale('ar');
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('Français'),
                                    onTap: () {
                                      ref
                                          .read(localeProvider.notifier)
                                          .state = const Locale('fr');
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.language),
                      );
                    },
                  ),
                ],
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
                    hintText: S.of(context).searchBar,
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
                ? Center(child: Text(S.of(context).body))
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
                      return Center(child: Text(S.of(context).movieNotFound));
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
                                    InfoRow(
                                      label: S.of(context).title,
                                      value: movie.title,
                                    ),
                                    const Divider(),
                                    InfoRow(
                                      label: S.of(context).year,
                                      value: movie.year,
                                    ),
                                    const Divider(),
                                    InfoRow(
                                      label: S.of(context).rated,
                                      value: movie.rated,
                                    ),
                                    const Divider(),
                                    InfoRow(
                                      label: S.of(context).runtime,
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
                                      S.of(context).plotSummary,
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
                                    title: S.of(context).imdbRating,
                                    value: movie.imdbRating,
                                    icon: Icons.star,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: RatingCard(
                                    title: S.of(context).rottenTomatoesRating,
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
                                      label: S.of(context).director,
                                      value: movie.director,
                                    ),
                                    const Divider(),
                                    InfoRow(
                                      label: S.of(context).writer,
                                      value: movie.writer,
                                    ),
                                    const Divider(),
                                    InfoRow(
                                      label: S.of(context).actors,
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
                                      label: S.of(context).boxOffice,
                                      value: movie.boxOffice,
                                    ),
                                    const Divider(),
                                    InfoRow(
                                      label: S.of(context).awards,
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
