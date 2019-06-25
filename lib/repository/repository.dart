
import 'package:movie_app_flutter/repository/movie_api_provider.dart';
import 'package:movie_app_flutter/model/item_model.dart';
import 'package:movie_app_flutter/model/movie_detail_model.dart';
import 'package:movie_app_flutter/model/movie_image_model.dart';

class Repository {
  final movieApiProvider = MovieApiProvider();

  Future<MovieDetailModel> fetchMovieDetails(int movieId) => movieApiProvider.fetchMovieDetails(movieId);
  Future<MovieImageModel> fetchMovieImages(int movieId) => movieApiProvider.fetchMovieImages(movieId);

  Future<ItemModel> fetchMovieList(String type) => movieApiProvider.fetchMovies(type);
}