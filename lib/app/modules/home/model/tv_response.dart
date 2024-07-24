
import 'dart:convert';

class TvResponse {
  int page;
  List<Tv> tv;
  int totalPages;
  int totalResults;

  TvResponse({
    required this.page,
    required this.tv,
    required this.totalPages,
    required this.totalResults,
  });

  factory TvResponse.fromRawJson(String str) => TvResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
    page: json["page"],
    tv: List<Tv>.from(json["results"].map((x) => Tv.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(tv.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Tv {
  bool adult;
  List<int> genreIds;
  int id;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String? posterPath;
  DateTime firstAirDate;
  String name;
  double voteAverage;
  int voteCount;

  Tv({
    required this.adult,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Tv.fromJson(Map<String, dynamic> json) {
    return Tv(
      adult: json["adult"],
      // Assign null if JSON value is null
      genreIds: List<int>.from(json["genre_ids"]),
      id: json["id"],
      originCountry: List<String>.from(json["origin_country"]),
      originalLanguage: json["original_language"],
      originalName: json["original_name"],
      overview: json["overview"],
      popularity: json["popularity"].toDouble(),
      posterPath: json["poster_path"],
      firstAirDate: DateTime.parse(json["first_air_date"]),
      name: json["name"],
      voteAverage: json["vote_average"].toDouble(),
      voteCount: json["vote_count"],
    );
  }

  toJson() {}
}