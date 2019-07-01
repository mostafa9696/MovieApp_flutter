
import 'package:movie_app_flutter/bloc/base_bloc.dart';
import 'package:movie_app_flutter/model/movie_image_model.dart';
import 'package:rxdart/rxdart.dart';

class MovieImagesBloc extends BaseBloc<MovieImageModel> {

    Observable<MovieImageModel> get movieImages => fetcher.stream;

    fetchMovieImages(int movieId) async {
      MovieImageModel model = await repository.fetchMovieImages(movieId);
      fetcher.sink.add(model);
    }
}

final movieImageBloc = MovieImagesBloc();