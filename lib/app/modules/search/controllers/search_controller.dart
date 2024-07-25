import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moviedb_get/app/modules/search/model/search_response.dart';
import 'package:moviedb_get/app/modules/search/service/search_service.dart';

class SearchesController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  RxBool isLoading = false.obs;
  RxList<Search> dataSearch = <Search>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> searchFilm(String query) async {
    isLoading.value = true;
    try {
      final SearchResponse searchResponse = await SearchService().searchMovie(query: query);
      dataSearch.clear();
      if (searchResponse.results.isNotEmpty) {
        dataSearch.value = searchResponse.results;
      }
    } catch (e) {
      print("Error fetching movie: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
