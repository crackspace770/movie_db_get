
import 'dart:convert';

class TvDetailResponse {
  bool error;
  String message;
  TvDetail tv;

  TvDetailResponse({
    required this.error,
    required this.message,
    required this.tv,
  });

  factory TvDetailResponse.fromRawJson(String str) => TvDetailResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) => TvDetailResponse(
    error: json["error"] ?? false,
    message: json["message"] ?? "",
    tv: TvDetail.fromJson(json),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "tv": tv.toJson(),
  };
}

TvDetail tvDetailFromJson(String str) => TvDetail.fromJson(json.decode(str));

String tvDetailToJson(TvDetail data) => json.encode(data.toJson());

class TvDetail {
  final int? id;
  final String? name;
  final String? originalTitle;
  final String? posterPath;
  final DateTime? firstAirDate;
  final double? voteAverage;
  final int? voteCount;
  final String? overview;

  TvDetail({
    this.id,
    this.name,
    this.originalTitle,
    this.posterPath,
    this.firstAirDate,
    this.voteAverage,
    this.voteCount,
    this.overview,
  });

  factory TvDetail.fromJson(Map<String, dynamic> json) {
    return TvDetail(
      id: json["id"],
      name: json['name'],
      originalTitle: json['original_title'],
      posterPath: json['poster_path'],
      firstAirDate: DateTime.parse(json['first_air_date']),
      voteAverage: (json['vote_average'] as num).toDouble(), // Ensure voteAverage is double
      voteCount: (json['vote_count'] as num).toInt(), // Ensure voteCount is int
      overview: json['overview'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'name': name,
      'original_title': originalTitle,
      'poster_path': posterPath,
      'first_air_date': firstAirDate?.toIso8601String(),
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'overview': overview,
    };
  }
}

class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class LastEpisodeToAir {
  int id;
  String overview;
  String name;
  int voteAverage;
  int voteCount;
  DateTime airDate;
  int episodeNumber;
  String episodeType;
  String productionCode;
  int runtime;
  int seasonNumber;
  int showId;
  dynamic stillPath;

  LastEpisodeToAir({
    required this.id,
    required this.overview,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
  });

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) => LastEpisodeToAir(
    id: json["id"],
    overview: json["overview"],
    name: json["name"],
    voteAverage: json["vote_average"],
    voteCount: json["vote_count"],
    airDate: DateTime.parse(json["air_date"]),
    episodeNumber: json["episode_number"],
    episodeType: json["episode_type"],
    productionCode: json["production_code"],
    runtime: json["runtime"],
    seasonNumber: json["season_number"],
    showId: json["show_id"],
    stillPath: json["still_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "overview": overview,
    "name": name,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "air_date": "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
    "episode_number": episodeNumber,
    "episode_type": episodeType,
    "production_code": productionCode,
    "runtime": runtime,
    "season_number": seasonNumber,
    "show_id": showId,
    "still_path": stillPath,
  };
}

class Network {
  int id;
  String? logoPath;
  String name;
  String originCountry;

  Network({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    id: json["id"],
    logoPath: json["logo_path"],
    name: json["name"],
    originCountry: json["origin_country"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "logo_path": logoPath,
    "name": name,
    "origin_country": originCountry,
  };
}

class Season {
  DateTime? airDate;
  int episodeCount;
  int id;
  String name;
  String overview;
  dynamic posterPath;
  int seasonNumber;
  double voteAverage;

  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory Season.fromJson(Map<String, dynamic> json) => Season(
    airDate: json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
    episodeCount: json["episode_count"],
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    seasonNumber: json["season_number"],
    voteAverage: json["vote_average"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "air_date": "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
    "episode_count": episodeCount,
    "id": id,
    "name": name,
    "overview": overview,
    "poster_path": posterPath,
    "season_number": seasonNumber,
    "vote_average": voteAverage,
  };
}

class SpokenLanguage {
  String englishName;
  String iso6391;
  String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
    englishName: json["english_name"],
    iso6391: json["iso_639_1"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "english_name": englishName,
    "iso_639_1": iso6391,
    "name": name,
  };
}
