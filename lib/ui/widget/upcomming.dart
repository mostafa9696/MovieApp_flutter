import 'package:flutter/material.dart';
import 'package:movie_app_flutter/bloc/movie_list_bloc.dart';
import 'package:movie_app_flutter/constants/global.dart';
import 'package:movie_app_flutter/model/item_model.dart';

class UpcommingMovies extends StatefulWidget {
  @override
  State createState() => _UpcommingMoviesState();
}

class _UpcommingMoviesState extends State<UpcommingMovies> {
  MovieListBloc _listBloc;


  @override
  void initState() {
    super.initState();
    _listBloc = MovieListBloc();
    _listBloc.fetchMovieList(MovieListType.upcoming);
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _listBloc.movieList,
      builder: (context, AsyncSnapshot<ItemModel> snapShot) {
        print("In Upcomming");
        if (snapShot.hasData) {
          return buildContent(snapShot, context);
        } else if (snapShot.hasError) {
          return Text(snapShot.error.toString());
        }
        return Container(
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget buildContent(AsyncSnapshot<ItemModel> snapShot, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      height: width / 4,
      margin: EdgeInsets.only(bottom: 10, top: 25),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapShot.data.results.length > 10
              ? 10
              : snapShot.data.results.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildItem(
                snapShot.data.results[index].backdrop_path,
                snapShot.data.results[index].release_date,
                width / 3,
                index == 0);
          }),
    );
  }

  Widget _buildItem(
      String imagePath, String release_date, double itemHeight, bool isFirst) {
    return Container(
      width: itemHeight * 4 / 3,
      height: itemHeight * 3 / 4,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10.0,
        margin: EdgeInsets.only(left: isFirst ? 20 : 10, right: 10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Stack(
          children: <Widget>[
            Image.network(
              'https://image.tmdb.org/t/p/w500$imagePath',
              fit: BoxFit.cover,
              width: itemHeight * 4 / 3,
              height: itemHeight * 3 / 4,
            ),
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  release_date,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Muli'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
