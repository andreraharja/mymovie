import 'package:dio/dio.dart';
import '../data_movie_model.dart';

class DataMovieProvider {
  Dio _dio = Dio();

  Future<List<DataMovie>> getDataMovie() async {
    try {
      Response response = await _dio.get(
          "https://api.themoviedb.org/3/discover/movie?api_key=f7b67d9afdb3c971d4419fa4cb667fbf");
      List<DataMovie> lsResult = [];
      response.data['results']
          .map((i) => lsResult.add(DataMovie.fromJson(i)))
          .toList();
      return lsResult;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
