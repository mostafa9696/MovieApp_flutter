import 'package:rxdart/rxdart.dart';
import 'package:movie_app_flutter/model/base_model.dart';
import 'package:movie_app_flutter/repository/repository.dart';

abstract class BaseBloc<T extends BaseModel> {
  final repository = Repository();
  final fetcher = PublishSubject<T>();

  dispose() {
    fetcher.close();
  }
}
