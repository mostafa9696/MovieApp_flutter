
import 'package:rxdart/rxdart.dart';
import 'package:movie_app_flutter/bloc/base_bloc.dart';
import 'package:movie_app_flutter/model/item_model.dart';

class MovieListBloc extends BaseBloc<ItemModel> {

    Observable<ItemModel> get movieList => fetcher.stream;
    fetchMovieList(String type)  async {
      ItemModel model = await repository.fetchMovieList(type);
      fetcher.sink.add(model);
    }
}

final movieListBloc = MovieListBloc();