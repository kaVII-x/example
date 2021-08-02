import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'data.dart';

class ApiKey {
  final String urlKEY = 'api_key=737409d2a3f0c86f8c201f042da6e49c';
  final String baseUrl = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlQUery =
      'https://api.themoviedb.org/3/search/movie?api_key=bdee8dbf63a51b21beba2f6278f0cde3&query=';

  Future<List> getUpcoming() async {
    final String url = baseUrl + urlUpcoming + urlKEY;
    http.Response result = await http.get(Uri.parse(url));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }

  Future<List> findMovies(String title) async {
    final String urlSearch = urlQUery + title;
    http.Response result = await http.get(Uri.parse(urlSearch));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }
}
