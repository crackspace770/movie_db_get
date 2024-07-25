import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moviedb_get/app/constants/const_variable.dart';
import 'package:moviedb_get/app/modules/detail/views/tv_detail_view.dart';
import 'package:moviedb_get/app/modules/home/controllers/home_controller.dart';
import 'package:moviedb_get/app/modules/home/model/trending_response.dart';

import '../../detail/views/detail_view.dart';

class TrendingList extends StatefulWidget {
  const TrendingList({super.key});

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => controller.isLoading.value
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : controller.dataTrending.isEmpty
            ? const Center(
          child: Text("No Data"),
        )
            : ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.dataTrending.length,
          itemBuilder: (context, index) {
            Trending trendingItem = controller.dataTrending[index];
            return CardTrending(
              trending: trendingItem,
              onTap: () {
                if (trendingItem.mediaType == MediaType.MOVIE) {
                  Get.to(DetailView(
                    id: trendingItem.id.toString() ?? "0",
                  ));
                } else if (trendingItem.mediaType == MediaType.TV) {
                  Get.to(TvDetailView(
                    id: trendingItem.id.toString() ?? "0",
                  ));
                }
              },
            );
          },
        ),
      ),
    );
  }
}


class CardTrending extends StatelessWidget {
  final Trending trending;
  final void Function()? onTap;

  const CardTrending({super.key, required this.trending, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Hero(
                tag: trending.posterPath.toString(),
                child: Image.network(
                  "${ConstVariable.imageUrl}${trending.posterPath}",
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, error, _) => const Center(
                    child: Icon(
                      Icons.error_outline_sharp,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 4.0),
          SizedBox(
            width: 100,
            child: Text(
              (trending.name?.isNotEmpty ?? false) ? trending.name! : (trending.originalTitle ?? ''),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 2.0),
          Row(
            children: [
              const Icon(
                Icons.date_range_outlined,
                color: Colors.blueAccent,
                size: 16.0,
              ),
              SizedBox(width: 2.0),
              Text(
                trending.releaseDate != null
                    ? DateFormat('yyyy-MM-dd').format(trending.releaseDate!)
                    : 'No Release Date',
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.blueAccent,
                size: 16.0,
              ),
              SizedBox(width: 2.0),
              Text(
                trending.voteAverage.toString(),
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
