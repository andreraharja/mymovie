import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymovie/app/modules/home/views/home_view_list.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Teravin Movie'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Obx(() => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : HomeListMovie()),
        ));
  }
}
