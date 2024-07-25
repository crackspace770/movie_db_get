import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_controller.dart';


class DetailView extends StatefulWidget {
  final String id;
  const DetailView({super.key, required this.id});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late final DetailController detailController;

  @override
  void initState() {
    super.initState();
    detailController = Get.put(DetailController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      detailController.getDetailMovie(id: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
          if (detailController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (detailController.dataDetailMovie.value.id == null) {
            return const Center(child: Text("Data not found"));
          } else{
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Stack(
                    children: [
                      if (detailController.dataDetailMovie.value.posterPath != null)
                        Image.network(
                          "https://image.tmdb.org/t/p/w500/${detailController.dataDetailMovie.value.posterPath}",
                          width: 500,
                          height: 500,

                        ),
                      SafeArea(
                        child: Opacity(
                          opacity: 0.5,
                          child: Container(
                            margin: const EdgeInsets.only(left: 25),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: ()=>Navigator.pop(context), // Changed this line
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      detailController.dataDetailMovie.value.title ??"",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Icon(
                            Icons.date_range,
                            color: Colors.blue,
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd').format(detailController.dataDetailMovie.value.releaseDate!),
                            style: const TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.blue,
                          ),
                          Text(
                            detailController.dataDetailMovie.value.voteAverage.toString(),
                            style: const TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.how_to_vote,
                            color: Colors.blue,
                          ),
                          Text(
                            detailController.dataDetailMovie.value.voteCount.toString(),
                            style: const TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      detailController.dataDetailMovie.value.overview!,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15)

                ],
              ),
            );
          }
      }),
    );
  }
}



