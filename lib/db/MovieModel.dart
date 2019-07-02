import 'dart:core';


class MovieModel {
  int _movieId;
  String _moviePoster;

  MovieModel(this._movieId, this._moviePoster);

  int get movieId => _movieId;

  set movieId(int value) {
    _movieId = value;
  }

  String get moviePoster => _moviePoster;

  set moviePoster(String value) {
    _moviePoster = value;
  }

  MovieModel.map(Map<String, dynamic> map) {
    this._movieId = map["movieId"];
    this._moviePoster = map["moviePoster"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["movieId"] = this._movieId;
    map["moviePoster"] = this._moviePoster;
    return map;
  }
}
