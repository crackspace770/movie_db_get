
import 'dart:convert';
import 'dart:ffi';

class MovieDetailResponse {
  bool error;
  String message;
  MovieDetail movie;

  MovieDetailResponse({
    required this.error,
    required this.message,
    required this.movie,
  });

  factory MovieDetailResponse.fromRawJson(String str) => MovieDetailResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) {
    return MovieDetailResponse(
      error: json["error"] ?? false, // Handle possible null value
      message: json["message"] ?? "",
      movie: MovieDetail.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "movie": movie.toJson(),
  };
}


class MovieDetail {
  final int? id;
  final String? title;
  final String? originalTitle;
  final String? posterPath;
  final DateTime? releaseDate;
  final double? voteAverage;
  final int? voteCount;
  final String? overview;

  MovieDetail({
    this.id,
    this.title,
    this.originalTitle,
    this.posterPath,
    this.releaseDate,
    this.voteAverage,
    this.voteCount,
    this.overview,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json["id"],
      title: json['title'],
      originalTitle: json['original_title'],
      posterPath: json['poster_path'],
      releaseDate: DateTime.parse(json['release_date']),
      voteAverage: (json['vote_average'] as num).toDouble(), // Ensure voteAverage is double
      voteCount: (json['vote_count'] as num).toInt(), // Ensure voteCount is int
      overview: json['overview'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'title': title,
      'original_title':originalTitle,
      'poster_path': posterPath,
      'release_date': releaseDate?.toIso8601String(),
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'overview': overview,
    };
  }
}
