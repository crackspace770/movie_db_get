import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.lightBlueAccent,
          ),
          Column(
            children: [
              const SizedBox(height: 400),
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  height: 75,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
