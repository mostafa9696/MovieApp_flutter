
import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:movie_app_flutter/model/item_model.dart';
import 'package:movie_app_flutter/model/movie_detail_model.dart';
import 'package:movie_app_flutter/model/movie_image_model.dart';

class MovieApiProvider {

  Client client = Client();
  final _apiKey = '802b2c4b88ea1183e50e6b285a27696e';

  Future<ItemModel> fetchMovies(String type) async {
    final response = await client
        .get("http://api.themoviedb.org/3/movie/$type?api_key=$_apiKey");
    if(response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<MovieDetailModel> fetchMovieDetails(int movieId) async {
     final response = await client
         .get("http://api.themoviedb.org/3/movie/$movieId?api_key=$_apiKey");
     if(response.statusCode == 200) {
       return MovieDetailModel.fromJson(json.decode(response.body));
     } else {
       throw Exception("Failed to load data");
     }
  }

  Future<MovieImageModel> fetchMovieImages(int movieId) async {
    final response = await client
        .get("http://api.themoviedb.org/3/movie/$movieId/images?api_key=$_apiKey");
    if(response.body == 200) {
      return MovieImageModel.fromJson(json.decode(response.body));
    }  else {
      throw Exception('Failed to load post');
    }
  }

}