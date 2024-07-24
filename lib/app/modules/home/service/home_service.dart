
import 'dart:convert';

import 'package:http/http.dart';
import 'package:moviedb_get/app/modules/home/model/trending_response.dart';

import '../../../constants/const_variable.dart';
import '../model/movie_response.dart';
import '../model/tv_response.dart';

class HomeService{

  final client = Client();
  final String baseUrl = ConstVariable.base_url;
  final String api_key = ConstVariable.api_key;
  final String movieList = ConstVariable.movieList;
  final String trendingList = ConstVariable.trending;
  final String tvList = ConstVariable.tvList;

  Future<MovieResponse> getMovieList() async {
    try {
      final response = await client.get(Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=e4f0bf9deb75ea82eec186d6a65814ae"));
      if (response.statusCode == 200) {
        print("Response: ${response.body}");  // Debug print
        return MovieResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Movie list: ${response.body}');
      }
    } catch (e) {
      print('Error fetching Movie list: $e');
      throw Exception('Failed to load Movie list: $e');
    }
  }

  Future<TvResponse> getTvList() async {
    try {
      final response = await client.get(Uri.parse("https://api.themoviedb.org/3/tv/popular?api_key=e4f0bf9deb75ea82eec186d6a65814ae"));
      if (response.statusCode == 200) {
        print("Response: ${response.body}");  // Debug print
        return TvResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Movie list: ${response.body}');
      }
    } catch (e) {
      print('Error fetching Movie list: $e');
      throw Exception('Failed to load Movie list: $e');
    }
  }

  Future<TrendingResponse> getTrendingList() async {
    try {
      final response = await client.get(Uri.parse("https://api.themoviedb.org/3/trending/all/week?api_key=e4f0bf9deb75ea82eec186d6a65814ae"));
      if (response.statusCode == 200) {
        print("Response: ${response.body}");  // Debug print
        return TrendingResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Movie list: ${response.body}');
      }
    } catch (e) {
      print('Error fetching Movie list: $e');
      throw Exception('Failed to load Movie list: $e');
    }
  }

}