// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Search for a movie...`
  String get searchBar {
    return Intl.message(
      'Search for a movie...',
      name: 'searchBar',
      desc: 'Hint text in the search bar',
      args: [],
    );
  }

  /// `Start searching for a movie by typing its title.`
  String get body {
    return Intl.message(
      'Start searching for a movie by typing its title.',
      name: 'body',
      desc: 'Initial body text before a search',
      args: [],
    );
  }

  /// `Movie not found`
  String get movieNotFound {
    return Intl.message(
      'Movie not found',
      name: 'movieNotFound',
      desc: 'Displayed when the movie is not found in the API',
      args: [],
    );
  }

  /// `Error: {error}`
  String errorMessage(Object error) {
    return Intl.message(
      'Error: $error',
      name: 'errorMessage',
      desc: 'Error message shown when request fails',
      args: [error],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: 'Title of the movie',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: 'Year of the movie',
      args: [],
    );
  }

  /// `Rated`
  String get rated {
    return Intl.message(
      'Rated',
      name: 'rated',
      desc: 'Rating of the movie',
      args: [],
    );
  }

  /// `Runtime`
  String get runtime {
    return Intl.message(
      'Runtime',
      name: 'runtime',
      desc: 'Runtime of the movie',
      args: [],
    );
  }

  /// `Plot Summary`
  String get plotSummary {
    return Intl.message(
      'Plot Summary',
      name: 'plotSummary',
      desc: 'Header for the plot summary section',
      args: [],
    );
  }

  /// `IMDb`
  String get imdbRating {
    return Intl.message(
      'IMDb',
      name: 'imdbRating',
      desc: 'Label for IMDb rating',
      args: [],
    );
  }

  /// `Rotten Tomatoes`
  String get rottenTomatoesRating {
    return Intl.message(
      'Rotten Tomatoes',
      name: 'rottenTomatoesRating',
      desc: 'Label for Rotten Tomatoes rating',
      args: [],
    );
  }

  /// `Director`
  String get director {
    return Intl.message(
      'Director',
      name: 'director',
      desc: 'Label for Director info row',
      args: [],
    );
  }

  /// `Writer`
  String get writer {
    return Intl.message(
      'Writer',
      name: 'writer',
      desc: 'Label for Writer info row',
      args: [],
    );
  }

  /// `Actors`
  String get actors {
    return Intl.message(
      'Actors',
      name: 'actors',
      desc: 'Label for Actors info row',
      args: [],
    );
  }

  /// `Box Office`
  String get boxOffice {
    return Intl.message(
      'Box Office',
      name: 'boxOffice',
      desc: 'Label for Box Office info row',
      args: [],
    );
  }

  /// `Awards`
  String get awards {
    return Intl.message(
      'Awards',
      name: 'awards',
      desc: 'Label for Awards info row',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
