import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:mymovie/app/data/data_movie_model.dart';
import 'package:mymovie/app/data/local/db_helper.dart';
import 'package:mymovie/app/data/local/db_movie.dart';
import 'package:mymovie/app/data/providers/data_movie_provider.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var isUpdated = false.obs;
  DbHelper _helper = new DbHelper();
  var totalMovie = 0.obs;

  List<DataMovie> lsResult = [];
  List<int> lsResultID = [];
  var lsDataMovie = List<DataMovie>.empty().obs;
  List<int> lsDataMovieID = [];
  List<int> diffIDOutput = [];

  @override
  void onInit() async {
    FlutterBackgroundService().invoke("setAsBackground");
    lsResult = await DataMovieProvider().getDataMovie();
    lsResult.forEach((element) {
      lsResultID.add(element.id!);
    });
    lsDataMovie.value = await _helper.localDataMovie();
    lsDataMovie.forEach((element) {
      lsDataMovieID.add(element.id!);
    });

    if (lsDataMovie.length > 0) {
      diffIDOutput =
          lsResultID.toSet().difference(lsDataMovieID.toSet()).toList();
      if (diffIDOutput.length > 0 || lsResult.length != lsDataMovie.length) {
        isUpdated(true);
      }
    } else {
      if (lsResult.length > 0) {
        lsResult.forEach((element) async {
          await _helper.insert(DBMovie.tableName, element.toJson());
        });
      }
    }

    lsDataMovie.value = await _helper.localDataMovie();
    if (lsDataMovie.length >= 10) {
      totalMovie.value = 10;
    } else {
      totalMovie.value = lsDataMovie.length;
    }
    isLoading(false);
    super.onInit();
  }

  void updateMovieList() {
    isLoading(true);
    lsDataMovie.clear();
    lsDataMovie.addAll(lsResult);
    if (lsDataMovie.length >= 10) {
      totalMovie.value = 10;
    } else {
      totalMovie.value = lsDataMovie.length;
    }
    isUpdated(false);
    isLoading(false);
  }
}
