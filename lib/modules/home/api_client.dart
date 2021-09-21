import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3/discover")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET(
      "/movie?sort_by=popularity.desc&api_key=d4706eb28719d30f2911e24ba47428d0")
  Future<MovieModel> getMovies();
}

@JsonSerializable()
class MovieModel {
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  MovieModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}

@JsonSerializable()
class Result {
  Result({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;

  NetworkError(this.statusCode, this.message);
}
