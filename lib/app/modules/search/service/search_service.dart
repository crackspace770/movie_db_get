import 'dart:convert';

import 'package:http/http.dart';

import '../../../constants/const_variable.dart';
import '../model/search_response.dart';

class SearchService{

  final client = Client();
  final String baseUrl = ConstVariable.base_url;
  final String api_key = ConstVariable.api_key;
  final String search = ConstVariable.movieSearch;


  Future <SearchResponse> searchMovie({String? query}) async{

    final response = await client.get(Uri.parse("https://api.themoviedb.org/3/search/multi?query=${query}&include_adult=true&api_key=e4f0bf9deb75ea82eec186d6a65814ae"));
    if(response == 200) {
      return SearchResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed to load movie");
    }
  }

}