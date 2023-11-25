import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

class DetailTV extends Equatable {
  final String id;
  final String name;
  final String overview;
  final String backgroundPath;
  final String status;
  final String type;
  final String voteAverage;
  final String popularity;
  final String firstAirDate;
  final String numberOfEpisodes;
  final String numberOfSeasons;
  final List<String> spokenLanguages;

  const DetailTV({
    required this.id,
    required this.name,
    required this.overview,
    required this.backgroundPath,
    required this.status,
    required this.type,
    required this.voteAverage,
    required this.popularity,
    required this.firstAirDate,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.spokenLanguages,
  });

  static Future<DetailTV> fetchDetailTV(String id) async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/tv/$id?api_key=9da44c390e219ffdc840f1bc8c1cd1b8',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return DetailTV(
        id: data['id'].toString(),
        name: data['name'] ?? "",
        overview: data['overview'] ?? "",
        backgroundPath:
            'https://image.tmdb.org/t/p/w500${data['backdrop_path']}',
        status: data['status'] ?? "",
        type: data['type'] ?? "",
        voteAverage: data['vote_average'].toString(),
        popularity: data['popularity'].toString(),
        firstAirDate: data['first_air_date'] ?? "",
        numberOfEpisodes: data['number_of_episodes'].toString(),
        numberOfSeasons: data['number_of_seasons'].toString(),
        spokenLanguages: List<String>.from(data['spoken_languages']
            .map((language) => language['name'].toString())),
      );
    } else {
      throw Exception('Failed to load TV details');
    }
  }

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        backgroundPath,
        status,
        type,
        voteAverage,
        popularity,
        firstAirDate,
        numberOfEpisodes,
        numberOfSeasons,
        spokenLanguages,
      ];
}
