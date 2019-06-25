import 'package:movie_app_flutter/model/base_model.dart';
import 'package:movie_app_flutter/model/belong_to_collection_model.dart';
import 'package:movie_app_flutter/model/genre_model.dart';
import 'package:movie_app_flutter/model/image_model.dart';
import 'package:movie_app_flutter/model/production_company_model.dart';
import 'package:movie_app_flutter/model/production_country_model.dart';
import 'package:movie_app_flutter/model/spoken_language.dart';

class MovieImageModel extends BaseModel {
  int id;
  List<ImageModel> posters = [];
  List<ImageModel> backdrops = [];
  MovieImageModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    posters = ImageModel.fromJsonArray(parsedJson['posters']);
    backdrops = ImageModel.fromJsonArray(parsedJson['backdrops']);
  }
}





