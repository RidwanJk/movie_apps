import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

class Movie extends Equatable {
  final String id;
  final String title;
  final String backdrop_path;
  final String genre_ids;
  final String overview;
  final String release_date;
  final String popularity;
  final String poster_path;

  const Movie({
    required this.id,
    required this.title,
    required this.backdrop_path,
    required this.genre_ids,
    required this.overview,
    required this.release_date,
    required this.popularity,
    required this.poster_path,
  });

  static Future<List<Movie>> fetchMovies() async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=9da44c390e219ffdc840f1bc8c1cd1b8'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      List<Movie> movies = List<Movie>.from(data['results'].map((movie) {
        return Movie(
          id: movie['id'].toString(),
          title: movie['title'] ?? "",
          backdrop_path:
              'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}',
          genre_ids: movie['genre_ids'].toString(),
          overview: movie['overview'] ?? "",
          release_date: movie['release_date'] ?? "",
          popularity: movie['id'].toString(),
          poster_path: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
        );
      }));

      return movies;
    } else {
      throw Exception('Failed to load articles');
    }
  }
static Future<List<Movie>> NowPlayingMovies() async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/now_playing?api_key=9da44c390e219ffdc840f1bc8c1cd1b8'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      List<Movie> nowPlaying = List<Movie>.from(data['results'].map((movie) {
        return Movie(
          id: movie['id'].toString(),
          title: movie['title'] ?? "",
          backdrop_path:
              'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}',
          genre_ids: movie['genre_ids'].toString(),
          overview: movie['overview'] ?? "",
          release_date: movie['release_date'] ?? "",
          popularity: movie['id'].toString(),
          poster_path: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
        );
      }));

       nowPlaying = nowPlaying.take(5).toList();

      return nowPlaying;
    } else {
      throw Exception('Failed to load articles');
    }
  }

  
  static Future<List<Movie>> OtherMovie() async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/discover/movie?api_key=9da44c390e219ffdc840f1bc8c1cd1b8'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      List<Movie> otherList = List<Movie>.from(data['results'].map((movie) {
        return Movie(
          id: movie['id'].toString(),
          title: movie['title'] ?? "",
          backdrop_path:
              'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}',
          genre_ids: movie['genre_ids'].toString(),
          overview: movie['overview'] ?? "",
          release_date: movie['release_date'] ?? "",
          popularity: movie['id'].toString(),
          poster_path: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
        );
      }));

      return otherList;
    } else {
      throw Exception('Failed to load articles');
    }
  }
  @override
  List<Object?> get props => [
        id,
        title,
        backdrop_path,
        genre_ids,
        overview,
        release_date,
        popularity,
        poster_path,
      ];
}
