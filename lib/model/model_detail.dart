import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:movie_apps/model/model_aktor.dart';

class MovieDetails extends Equatable {
  final String id;
  final String title;
  final String overview;
  final List<String> genres;
  final List<Aktor> cast;
  final String image; // Daftar pemeran

  const MovieDetails({
    required this.id,
    required this.title,
    required this.overview,
    required this.genres,
    required this.cast,
    required this.image,
  });

  static Future<MovieDetails> fetchMovieDetails(String id) async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=9da44c390e219ffdc840f1bc8c1cd1b8&append_to_response=videos,credits',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      List<String> genres = List<String>.from(data['genres'].map((genre) {
        return genre['name'] ?? "";
      }));

      List<Aktor> cast = List<Aktor>.from(data['credits']['cast'].map((actor) {
        return Aktor(
          id: actor['id'].toString(),
          name: actor['name'] ?? "",
          profilePath:
              'https://image.tmdb.org/t/p/w500${actor['profile_path']}',
        );
      }));

      return MovieDetails(
        id: data['id'].toString(),
        title: data['title'] ?? "",
        overview: data['overview'] ?? "",
        genres: genres,
        cast: cast,
        image: 'https://image.tmdb.org/t/p/w500${data['backdrop_path']}',
      );
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  @override
  List<Object?> get props => [id, title, overview, cast, genres, image];
}
