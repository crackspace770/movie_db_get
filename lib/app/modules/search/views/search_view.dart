import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moviedb_get/app/constants/const_variable.dart';

import '../../detail/views/detail_view.dart';
import '../../detail/views/tv_detail_view.dart';
import '../controllers/search_controller.dart';
import '../model/search_response.dart';


class SearchView extends GetView<SearchesController> {
  final searchController = Get.put(SearchesController());
  final FocusNode _focusNode = FocusNode();

  SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: searchController.searchController,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),

                      hintText: "What movie you're looking for?",
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                    onChanged: (keyword) {
                      searchController.searchFilm(keyword);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Obx(
                    () => searchController.isLoading.value
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : searchController.dataSearch.isEmpty
                    ? const Center(
                  child: Text("No Data"),
                )
                    : ListView.builder(
                  itemCount: searchController.dataSearch.length,
                  itemBuilder: (context, index) {
                    Search searchItem = searchController.dataSearch[index];
                    return CardSearch(
                      search: searchItem,
                      onTap: () {
                        if (searchItem.mediaType == MediaType.MOVIE) {
                          Get.to(DetailView(
                            id: searchItem.id.toString(),
                          ));
                        } else if (searchItem.mediaType == MediaType.TV) {
                          Get.to(TvDetailView(
                            id: searchItem.id.toString(),
                          ));
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardSearch extends StatelessWidget {
  final Search search;
  final void Function()? onTap;

  const CardSearch({super.key, required this.search, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          height: MediaQuery.of(context).size.height/5.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            children: [
              search.posterPath != null
                  ? Hero(
                tag: search.posterPath ?? '',
                child: Image.network(
                  "${ConstVariable.imageUrl}${search.posterPath ?? ''}",
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, error, _) => const Center(
                    child: Icon(
                      Icons.error_outline_sharp,
                      color: Colors.red,
                    ),
                  ),
                ),
              )
                  : Container(
                width: 100,
                height: 100,
                color: Colors.grey,
                child: const Icon(
                  Icons.image_not_supported,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 15),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        (search.name?.isNotEmpty ?? false) ? search.name! : (search.title ?? ''),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Text(search.voteAverage.toString() ?? ''),
                        const Icon(Icons.star),
                      ],
                    ),
                    Text(DateFormat('yyyy-MM-dd').format(search.firstAirDate!)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


