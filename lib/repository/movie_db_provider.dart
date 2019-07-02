
import 'package:movie_app_flutter/db/DatabaseHelper.dart';
import 'package:movie_app_flutter/db/MovieModel.dart';

class MovieDbProvider {

  var db = DatabaseHelper();

  Future<List<MovieModel>> getFavoritMovies() async {
    List movies = await db.getAllFav();
    List<MovieModel> favoriteMovies = List();
    for(int i = 0 ; i < movies.length ; i++) {
      favoriteMovies.add(MovieModel.map(movies[i]));
    }
    return favoriteMovies;
  }

}