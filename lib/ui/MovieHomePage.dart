import 'package:flutter/material.dart';
import 'package:movie_app_flutter/constants/global.dart';
import 'package:movie_app_flutter/db/DatabaseHelper.dart';
import 'package:movie_app_flutter/ui/widget/FavoritesMovieView.dart';
import 'package:movie_app_flutter/ui/widget/MovieDetails.dart';
import 'package:movie_app_flutter/ui/widget/MovieListView.dart';
import 'package:movie_app_flutter/ui/widget/SlideShow.dart';
import 'package:movie_app_flutter/ui/widget/upcomming.dart';
import 'package:movie_app_flutter/utils/my_scroll_behavior.dart';

class MovieHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MovieHomePage> {
  DatabaseHelper db;

  @override
  void initState() {
    super.initState();
    db = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    print("Build MovieHomePage");
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie App"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: ScrollConfiguration(
            //  ScrollConfiguration Creates a widget that controls how [Scrollable] widgets behave in a subtree
            behavior: MyScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SlidShowView(
                    onItemClick: (movieId) {
                      _navigateToMovieDetail(context, movieId);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  UpcommingMovies(),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  _buildPlayingNowList(context),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  _buildFavList(context),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildPlayingNowList(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("Top rated movies",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Muli")),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                )
              ],
            ),
          ),
          MovieListView(
            type: MovieListType.topRated,
            onItemInteraction: (movieId) {
              _navigateToMovieDetail(context, movieId);
            },
          )
        ],
      ),
    );
  }

  Widget _buildFavList(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("Favorite",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Muli")),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                )
              ],
            ),
          ),
          FavoritesMovieView(
            onClickItem: (movieId) {
              _navigateToMovieDetail(context, movieId);
            },
          )
        ],
      ),
    );
  }

  _navigateToMovieDetail(BuildContext context, int movieId) async {
    bool isFav = await db.isMovieFav(movieId);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MovieDetails(
                  movieId: movieId,
                  isFav: isFav,
                )));
  }
}
