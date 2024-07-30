import 'package:get/get.dart';
import 'package:moviedb_get/app/modules/detail/model/movie_detail_response.dart';
import 'package:moviedb_get/app/modules/detail/service/detail_service.dart';

import '../../favorites/controllers/favorites_controller.dart';
import '../../favorites/database/db_helper.dart';
import '../../home/model/trending_response.dart';
import '../model/tv_detail_response.dart';

class DetailController extends GetxController {
  Rx<MovieDetail> dataDetailMovie = MovieDetail().obs;
  Rx<TvDetail> dataDetailTv = TvDetail().obs;
  RxBool isLoading = false.obs;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getDetailMovie({String? id}) async {
    isLoading.value = true;
    final MovieDetailResponse detailMovie =
    await DetailService().getMovieDetail(id: id);
    dataDetailMovie.value = detailMovie.movie;
    isLoading.value = false;
  }

  Future<void> getDetailTv({String? id}) async {
    isLoading.value = true;
    final TvDetailResponse detailTv =
    await DetailService().getTvDetail(id: id);
    dataDetailTv.value = detailTv.tv;
    isLoading.value = false;
  }

  Future<void> addFavorite(Trending trending) async {
    await _dbHelper.insertFavorite(trending);
  }

  Future<void> removeFavorite(String id) async {
    await _dbHelper.removeFavorite(id);
  }

  Future<bool> isFavorite(String id) async {
    final favorite = await _dbHelper.getFavoriteById(id);
    return favorite.isNotEmpty;
  }


}