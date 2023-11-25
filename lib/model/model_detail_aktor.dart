import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

class DetailAktor extends Equatable {
  final String id;
  final String name;
  final String profilePath;
  final String biography;
  final String placeOfBirth;
  final String birthday;

  const DetailAktor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.biography,
    required this.placeOfBirth,
    required this.birthday,
  });

  static Future<DetailAktor> fetchActorDetails(String actorId) async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/person/$actorId?api_key=9da44c390e219ffdc840f1bc8c1cd1b8',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return DetailAktor(
        id: data['id'].toString(),
        name: data['name'] ?? "",
        profilePath: 'https://image.tmdb.org/t/p/w500${data['profile_path']}',
        biography: data['biography'] ?? "",
        placeOfBirth: data['place_of_birth'] ?? "",
        birthday: data['birthday'] ?? "",
      );
    } else {
      throw Exception('Failed to load actor details');
    }
  }

  @override
  List<Object?> get props => [id, name, profilePath, biography, placeOfBirth, birthday];
}
