// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) {
  return MovieModel(
    page: json['page'] as int?,
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
        .toList(),
    totalPages: json['total_pages'] as int?,
    totalResults: json['total_results'] as int?,
  );
}

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'totalPages': instance.totalPages,
      'totalResults': instance.totalResults,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    adult: json['adult'] as bool?,
    backdropPath: json['backdrop_path'] as String?,
    genreIds:
        (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
    id: json['id'] as int?,
    originalLanguage: json['original_language'] as String?,
    originalTitle: json['original_title'] as String?,
    overview: json['overview'] as String?,
    popularity: (json['popularity'] as num?)?.toDouble(),
    posterPath: json['poster_path'] as String?,
    releaseDate: json['release_date'] == null
        ? null
        : DateTime.parse(json['release_date'] as String),
    title: json['title'] as String?,
    video: json['video'] as bool?,
    voteAverage: (json['vote_average'] as num?)?.toDouble(),
    voteCount: json['vote_count'] as int?,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'adult': instance.adult,
      'backdropPath': instance.backdropPath,
      'genreIds': instance.genreIds,
      'id': instance.id,
      'originalLanguage': instance.originalLanguage,
      'originalTitle': instance.originalTitle,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'posterPath': instance.posterPath,
      'releaseDate': instance.releaseDate?.toIso8601String(),
      'title': instance.title,
      'video': instance.video,
      'voteAverage': instance.voteAverage,
      'voteCount': instance.voteCount,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.themoviedb.org/3/discover';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<MovieModel> getMovies() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        MovieModel>(Options(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra)
        .compose(_dio.options,
            '/movie?sort_by=popularity.desc&api_key=d4706eb28719d30f2911e24ba47428d0',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MovieModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
