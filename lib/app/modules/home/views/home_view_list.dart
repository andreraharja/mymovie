import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/home_controller.dart';

class HomeListMovie extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Expanded(
              child: ListView.builder(
                  itemCount: controller.totalMovie.value,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.lsDataMovie[index].originalTitle!,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              DateFormat("dd MMMM yyyy").format(DateTime.parse(
                                  controller.lsDataMovie[index].releaseDate!)),
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )),
        Obx(() => controller.isUpdated.value
            ? Column(
                children: [
                  Text('Penyimpanan Lokal Diperbarui'),
                  TextButton(
                      onPressed: () {
                        controller.updateMovieList();
                      },
                      child: Text('Update Movie List')),
                ],
              )
            : Container())
      ],
    );
  }
}
