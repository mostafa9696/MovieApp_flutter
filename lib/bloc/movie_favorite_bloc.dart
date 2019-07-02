import 'package:movie_app_flutter/bloc/base_bloc.dart';
import 'package:movie_app_flutter/db/FavoriteMovies.dart';
import 'package:movie_app_flutter/db/MovieModel.dart';
import 'package:rxdart/rxdart.dart';

class MovieFavoriteBloc extends BaseBloc<FavoriteMovies> {

  Observable<FavoriteMovies> get favoriteMovies => fetcher.stream;

  fetchFavoritMovies() async {
    List<MovieModel> movies = await repository.fetchFavoritMovies();
    FavoriteMovies favoriteMovies = FavoriteMovies(movies);
    fetcher.sink.add(favoriteMovies);
  }

}

var movieFavoriteBloc = MovieFavoriteBloc();
