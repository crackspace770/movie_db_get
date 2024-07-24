import 'package:get/get.dart';
import 'package:moviedb_get/app/modules/detail/model/movie_detail_response.dart';
import 'package:moviedb_get/app/modules/detail/service/detail_service.dart';

import '../model/tv_detail_response.dart';

class DetailController extends GetxController {

  Rx<MovieDetail> dataDetailMovie = MovieDetail().obs;
  Rx<TvDetail> dataDetailTv = TvDetail().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getDetailMovie({String? id}) async{
    isLoading.value = true;

    final MovieDetailResponse detailMovie =
        await DetailService().getMovieDetail(id:id);
    dataDetailMovie.value = detailMovie.movie;
    isLoading.value = false;
  }

  Future<void> getDetailTv({String? id}) async{
    isLoading.value = true;

    final TvDetailResponse detailMovie =
    await DetailService().getTvDetail(id:id);
    dataDetailTv.value = detailMovie.tv;
    isLoading.value = false;
  }

}
