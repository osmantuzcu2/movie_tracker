import 'dart:convert';
import 'dart:io';
import 'home_model.dart';
import 'package:http/http.dart' as http;

abstract class HomeRepository {
  Future<MovieModel> getMovies();
}

class HomeService implements HomeRepository {
  String baseUrl =
      "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=d4706eb28719d30f2911e24ba47428d0";
  @override
  Future<MovieModel> getMovies() async {
    final response = await http.get(Uri.parse(baseUrl));

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonBody = jsonDecode(response.body);
        return MovieModel.fromJson(jsonBody);
      default:
        throw NetworkError(response.statusCode.toString(), response.body);
    }
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;

  NetworkError(this.statusCode, this.message);
}
