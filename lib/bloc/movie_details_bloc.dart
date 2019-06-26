
import 'package:movie_app_flutter/bloc/base_bloc.dart';
import 'package:movie_app_flutter/model/movie_detail_model.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailsBloc extends BaseBloc<MovieDetailModel> {
  Observable<MovieDetailModel> get movieDetails => fetcher.stream;

  fetchMovieDetails(int movieId) async {
    MovieDetailModel model = await repository.fetchMovieDetails(movieId);
    fetcher.sink.add(model);
  }
}

final movieDetailsBloc = MovieDetailsBloc();