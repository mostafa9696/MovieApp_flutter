import 'package:flutter/material.dart';
import 'package:movie_app_flutter/bloc/movie_favorite_bloc.dart';
import 'package:movie_app_flutter/db/FavoriteMovies.dart';

class FavoritesMovieView extends StatefulWidget {
  final Function(int movieId) onClickItem;

  FavoritesMovieView({Key key, this.onClickItem}) : super(key: key);

  @override
  State createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoritesMovieView> {
  @override
  Widget build(BuildContext context) {
    movieFavoriteBloc.fetchFavoritMovies();
    return StreamBuilder(
      stream: movieFavoriteBloc.favoriteMovies,
      builder: (context, AsyncSnapshot<FavoriteMovies> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null ||
              snapshot.data.movieModels == null ||
              snapshot.data.movieModels.isEmpty) {
            return emptyContent();
          }
          print("lenn : $snapshot.data.movieModels.length");
          return buildContent(snapshot, context);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Container(
            padding: EdgeInsets.all(20.0),
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget buildContent(
      AsyncSnapshot<FavoriteMovies> snapshot, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: width / 1.75,
      margin: EdgeInsets.only(bottom: 10, top: 20),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data.movieModels.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: () {
                  if (widget.onClickItem != null) {
                    widget
                        .onClickItem(snapshot.data.movieModels[index].movieId);
                  } else {
                    debugPrint("Error click");
                  }
                },
                child: _buildItem(snapshot.data.movieModels[index].moviePoster,
                    width / 4, index == 0));
          }),
    );
  }

  _buildItem(String poster_path, double height, bool isFirst) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      margin: EdgeInsets.only(left: isFirst ? 20 : 10, right: 10, bottom: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Image.network(
        'https://image.tmdb.org/t/p/w500$poster_path',
        fit: BoxFit.cover,
        width: height * 4 / 3,
        height: height / 2,
      ),
    );
  }

  Widget emptyContent() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        "There are no favorites",
        style: TextStyle(
            fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.bold),
      ),
    );
  }
}
