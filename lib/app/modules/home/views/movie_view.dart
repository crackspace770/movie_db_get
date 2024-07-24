import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moviedb_get/app/modules/home/controllers/home_controller.dart';
import 'package:moviedb_get/app/modules/home/model/movie_response.dart';

import '../../../constants/const_variable.dart';
import '../../detail/views/detail_view.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => controller.isLoading.value
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : controller.dataMovie.isEmpty
            ? const Center(
          child: Text("No Data"),
        )
            : ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.dataMovie.length,
          itemBuilder: (context, index) {
            return CardMovie(
              movie: controller.dataMovie[index],
              onTap: () {
                Get.to(DetailView(
                  id: controller
                      .dataMovie[index].id.toString() ??
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

class CardMovie extends StatelessWidget {
  final Movie movie;
  final void Function()? onTap;

  const CardMovie({super.key, required this.movie, this.onTap});

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
                tag: movie.posterPath,
                child: Image.network(
                  "${ConstVariable.imageUrl}${movie.posterPath}",

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
              movie.title,
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
                DateFormat('yyyy-MM-dd').format(movie.releaseDate),
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
                movie.voteAverage.toString(),
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ),
        ],
      ),
    );
  }



}

