import 'dart:convert';

import 'package:http/http.dart';
import 'package:moviedb_get/app/modules/detail/model/movie_detail_response.dart';
import 'package:moviedb_get/app/modules/detail/model/tv_detail_response.dart';

import '../../../constants/const_variable.dart';

class DetailService{

  final client = Client();
  final String baseUrl = ConstVariable.base_url;
  final String api_key = ConstVariable.api_key;

  Future<MovieDetailResponse> getMovieDetail({String? id}) async{

    try {
      final response = await client.get(Uri.parse("https://api.themoviedb.org/3/movie/${id}?api_key=e4f0bf9deb75ea82eec186d6a65814ae"));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse); // Add this line to print the JSON response
        return MovieDetailResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load top headlines');
      }
    } on Error catch (e) {
      print('Error: $e');
      throw Exception('Something went wrong ');
    }

  }

  Future <TvDetailResponse> getTvDetail({String? id}) async{

    try{
      final response = await client.get(Uri.parse("https://api.themoviedb.org/3/tv/${id}?api_key=e4f0bf9deb75ea82eec186d6a65814ae"));
      if(response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        return TvDetailResponse.fromJson(jsonResponse);
      } else{
        throw Exception('Failed to load Series');
      }
    } on Error catch (e) {
      print('Error: $e');
      throw Exception('Something went wrong');
    }

  }


}