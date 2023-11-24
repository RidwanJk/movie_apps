import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

class Aktor extends Equatable {
  final String id;
  final String name;
  final String profilePath;

  const Aktor({
    required this.id,
    required this.name,
    required this.profilePath,
  });

  static Future<List<Aktor>> fetchActors() async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/trending/person/week?api_key=9da44c390e219ffdc840f1bc8c1cd1b8',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      List<Aktor> actors = List<Aktor>.from(data['results'].map((actor) {
        return Aktor(
          id: actor['id'].toString(),
          name: actor['name'] ?? "",
          profilePath:
              'https://image.tmdb.org/t/p/w500${actor['profile_path']}',
        );
      }));

      return actors;
    } else {
      throw Exception('Failed to load actors');
    }
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
