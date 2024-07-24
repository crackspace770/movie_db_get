import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moviedb_get/app/modules/detail/views/tv_detail_view.dart';
import 'package:moviedb_get/app/modules/home/controllers/home_controller.dart';
import 'package:moviedb_get/app/modules/home/model/tv_response.dart';

import '../../../constants/const_variable.dart';
import '../../detail/views/detail_view.dart';

class TvView extends StatefulWidget {
  const TvView({super.key});

  @override
  State<TvView> createState() => _TvViewState();
}

class _TvViewState extends State<TvView> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => controller.isLoading.value
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : controller.dataTv.isEmpty
            ? const Center(
          child: Text("No Data"),
        )
            : ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.dataTv.length,
          itemBuilder: (context, index) {
            return CardTv(
              tv: controller.dataTv[index],
              onTap: () {
                Get.to(TvDetailView(
                  id: controller
                      .dataTv[index].id.toString() ??
                      "0",
                ));
              },
            );
          },
        ),
      ),
    );
  }

}

class CardTv extends StatelessWidget {
  final Tv tv;
  final void Function()? onTap;

  const CardTv({super.key, required this.tv, required this.onTap});

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
                tag: tv.posterPath.toString(),
                child: Image.network(
                  "${ConstVariable.imageUrl}${tv.posterPath}",

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
              tv.name,
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
                DateFormat('yyyy-MM-dd').format(tv.firstAirDate),
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
                tv.voteAverage.toString(),
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ),
        ],
      ),
    );
  }


}

