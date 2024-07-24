import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moviedb_get/app/modules/home/views/movie_view.dart';
import 'package:moviedb_get/app/modules/home/views/trending_view.dart';
import 'package:moviedb_get/app/modules/home/views/tv_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MovieDB'),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          SizedBox(height: 16),
          Text("Trending Now",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
          ),
          SizedBox(height: 8),
          Expanded(
              child:TrendingList(),
          ),
          SizedBox(height: 8),
          Text("New Movies",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child:MovieView(),
          ),
          SizedBox(height: 8),
          Text("Tv Recommendation",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child:TvView(),
          ),
        ],
      ),
    );
  }
}
