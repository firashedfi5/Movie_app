// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(error) => "Error: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "actors": MessageLookupByLibrary.simpleMessage("Actors"),
    "awards": MessageLookupByLibrary.simpleMessage("Awards"),
    "body": MessageLookupByLibrary.simpleMessage(
      "Start searching for a movie by typing its title.",
    ),
    "boxOffice": MessageLookupByLibrary.simpleMessage("Box Office"),
    "director": MessageLookupByLibrary.simpleMessage("Director"),
    "errorMessage": m0,
    "imdbRating": MessageLookupByLibrary.simpleMessage("IMDb"),
    "movieNotFound": MessageLookupByLibrary.simpleMessage("Movie not found"),
    "plotSummary": MessageLookupByLibrary.simpleMessage("Plot Summary"),
    "rated": MessageLookupByLibrary.simpleMessage("Rated"),
    "rottenTomatoesRating": MessageLookupByLibrary.simpleMessage(
      "Rotten Tomatoes",
    ),
    "runtime": MessageLookupByLibrary.simpleMessage("Runtime"),
    "searchBar": MessageLookupByLibrary.simpleMessage("Search for a movie..."),
    "title": MessageLookupByLibrary.simpleMessage("Title"),
    "writer": MessageLookupByLibrary.simpleMessage("Writer"),
    "year": MessageLookupByLibrary.simpleMessage("Year"),
  };
}
