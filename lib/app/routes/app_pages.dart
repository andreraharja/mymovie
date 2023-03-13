import 'package:get/get.dart';
import 'package:mymovie/app/modules/error/views/error_view.dart';
import 'package:mymovie/app/modules/home/bindings/home_binding.dart';
import 'package:mymovie/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static String initPage(String con) {
    if (con == "Connected") {
      return Routes.HOME;
    } else {
      return Routes.ERROR;
    }
  }

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ERROR,
      page: () => ErrorView(),
    ),
  ];
}
