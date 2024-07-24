import 'package:get/get.dart';
import 'package:moviedb_get/app/modules/home/model/trending_response.dart';
import 'package:moviedb_get/app/modules/home/service/home_service.dart';

import '../model/movie_response.dart';
import '../model/tv_response.dart';

class HomeController extends GetxController {

  RxBool isLoading = false.obs;
  RxList<Movie> dataMovie = <Movie>[].obs;
  RxList<Tv>dataTv = <Tv>[].obs;
  RxList<Trending>dataTrending = <Trending>[].obs;
  Rx<Trending> dataTrendings = Trending().obs;


  @override
  void onInit() {
    super.onInit();
    getListTrending();
    getListMovie();
    getListTv();
  }

  Future<void> getListTrending() async{
    isLoading.value = true;
    try{
      final TrendingResponse trendingResponse = await HomeService().getTrendingList();
      dataTrending.clear();
      if(trendingResponse.trendings!.isNotEmpty) {
        dataTrending.value = trendingResponse.trendings;
      }
    } catch (e) {
      print("Error fetching trending list: $e");
    }finally{
      isLoading.value = false;
    }
  }

  Future<void> getListMovie() async{
    isLoading.value = true;
    try{
      final MovieResponse movieResponse = await HomeService().getMovieList();
      dataMovie.clear();
      if(movieResponse.movies!.isNotEmpty) {
        dataMovie.value = movieResponse.movies;
      }
    } catch (e) {
      print("Error fetching movie: $e");
    }finally {
      isLoading.value = false;
    }
  }

  Future<void> getListTv() async{
    isLoading.value = true;
    try{
      final TvResponse tvResponse = await HomeService().getTvList();
      dataTv.clear();
      if(tvResponse.tv!.isNotEmpty) {
        dataTv.value = tvResponse.tv;
      }
    } catch (e) {
      print("Error fetching TV: $e");
    }finally {
      isLoading.value = false;
    }
  }


}
