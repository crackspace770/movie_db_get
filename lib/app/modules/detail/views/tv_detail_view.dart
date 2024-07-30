
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../favorites/controllers/favorites_controller.dart';
import '../../home/model/trending_response.dart';
import '../controllers/detail_controller.dart';

class TvDetailView extends StatefulWidget {
  final String id;
  const TvDetailView({super.key, required this.id});

  @override
  State<TvDetailView> createState() => _TvDetailViewState();
}

class _TvDetailViewState extends State<TvDetailView> {
  late final DetailController detailController;

  @override
  void initState() {
    super.initState();
    detailController = Get.put(DetailController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      detailController.getDetailTv(id: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (detailController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (detailController.dataDetailTv.value.id == null) {
          return const Center(child: Text("Data not found"));
        } else {
          final tvShow = detailController.dataDetailTv.value;
          final isFavoriteFuture = detailController.isFavorite(tvShow.id.toString());

          return FutureBuilder<bool>(
            future: isFavoriteFuture,
            builder: (context, snapshot) {
              final isFavorite = snapshot.data ?? false;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Stack(
                      children: [
                        if (tvShow.posterPath != null)
                          Image.network(
                            "https://image.tmdb.org/t/p/w500/${tvShow.posterPath}",
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SafeArea(
                              child: Opacity(
                                opacity: 0.5,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 25),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: Colors.blue,
                                size: 30,
                              ),
                              onPressed: () async {
                                if (isFavorite) {
                                  await detailController.removeFavorite(tvShow.id.toString());
                                } else {
                                  final trending = Trending(
                                    id: tvShow.id,
                                    name: tvShow.name,
                                    originalName: tvShow.originalTitle,
                                    overview: tvShow.overview,
                                    posterPath: tvShow.posterPath,
                                    mediaType: MediaType.TV,
                                    firstAirDate: tvShow.firstAirDate,
                                    voteAverage: tvShow.voteAverage,
                                  );
                                  await detailController.addFavorite(trending);
                                }
                                setState(() {}); // Refresh UI
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        tvShow.name ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),


                    const SizedBox(height: 15)


                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}

