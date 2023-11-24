import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

class TVShow extends Equatable {
  final String id;
  final String name;
  final String posterPath;
  final String overview;
  final double popularity;
  final String firstAirDate;

  const TVShow({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
    required this.popularity,
    required this.firstAirDate,
  });

  static Future<List<TVShow>> fetchTVShows() async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/tv/popular?api_key=9da44c390e219ffdc840f1bc8c1cd1b8',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      List<TVShow> tvShows = List<TVShow>.from(data['results'].map((tvShow) {
        return TVShow(
          id: tvShow['id'].toString(),
          name: tvShow['name'] ?? "",
          posterPath: 'https://image.tmdb.org/t/p/w500${tvShow['poster_path']}',
          overview: tvShow['overview'] ?? "",
          popularity: (tvShow['popularity'] ?? 0.0).toDouble(),
          firstAirDate: tvShow['first_air_date'] ?? "",
        );
      }));

      return tvShows;
    } else {
      throw Exception('Failed to load TV shows');
    }
  }

  @override
  List<Object?> get props => [id, name, posterPath, overview, popularity, firstAirDate];
}
