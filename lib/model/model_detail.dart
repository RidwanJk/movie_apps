import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;


class MovieDetails extends Equatable {
  final String id;
  final String title;
  final String overview;
  final List<String> genres;
  final List<CastModel> cast;
  final String image;

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

      List<CastModel> castList = (data['credits']['cast'] as List)
          .map((cast) => CastModel.fromJson(cast))
          .toList();

      return MovieDetails(
        id: data['id'].toString(),
        title: data['title'] ?? "",
        overview: data['overview'] ?? "",
        genres: genres,
        cast: castList,

        image: 'https://image.tmdb.org/t/p/w500${data['backdrop_path']}',
      );
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  @override
  List<Object?> get props => [id, title, overview, genres, cast, image];
}

class CastModel {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String profilePath;
  final int castId;
  final String character;
  final String creditId;
  final int order;

  CastModel({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      adult: json['adult'] ?? false,
      gender: json['gender'] ?? 0,
      id: json['id'] ?? 0,
      knownForDepartment: json['known_for_department'] ?? '',
      name: json['name'] ?? '',
      originalName: json['original_name'] ?? '',
      popularity: json['popularity'] ?? 0.0,
      profilePath: json['profile_path'] ?? '',
      castId: json['cast_id'] ?? 0,
      character: json['character'] ?? '',
      creditId: json['credit_id'] ?? '',
      order: json['order'] ?? 0,
    );
  }
}
