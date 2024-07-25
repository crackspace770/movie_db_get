
class SearchResponse {
  final int page;
  final List<Search> results;
  final int totalPages;
  final int totalResults;

  SearchResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      page: json['page'] ?? 0,
      results: (json['results'] as List)
          .map((i) => Search.fromJson(i))
          .toList(),
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((result) => result.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}



class Search {
  final bool? adult;
  final String? backdropPath;
  final int? id;
  final String? title;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final MediaType? mediaType;
  final DateTime? releaseDate;
  final double? voteAverage;
  final String? name;
  final String? originalName;
  final DateTime? firstAirDate;

  Search({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.releaseDate,
    this.voteAverage,
    this.name,
    this.originalName,
    this.firstAirDate,
  });

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'] ?? '',
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      mediaType: mediaTypeValues.map[json['media_type']] ?? MediaType.MOVIE,
      releaseDate: json['release_date'] != null
          ? DateTime.parse(json['release_date'])
          : DateTime.now(),
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      name: json['name'] ?? '',
      originalName: json['original_name'] ?? '',
      firstAirDate: json['first_air_date'] != null
          ? DateTime.parse(json['first_air_date'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'media_type': mediaTypeValues.reverse[mediaType],
      'release_date': releaseDate?.toIso8601String(),
      'vote_average': voteAverage,
      'name': name,
      'original_name': originalName,
      'first_air_date': firstAirDate?.toIso8601String(),
    };
  }
}

enum MediaType { MOVIE, TV }

final mediaTypeValues = EnumValues({
  'movie': MediaType.MOVIE,
  'tv': MediaType.TV,
});

class EnumValues<T> {
  final Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
