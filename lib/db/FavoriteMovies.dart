
import 'package:movie_app_flutter/db/MovieModel.dart';
import 'package:movie_app_flutter/model/base_model.dart';

class FavoriteMovies extends BaseModel {

  List<MovieModel> _movieModels;

  List<MovieModel> get movieModels => _movieModels;


  FavoriteMovies(this._movieModels);

  set movieModels(List<MovieModel> value) {
    _movieModels = value;
  }


}