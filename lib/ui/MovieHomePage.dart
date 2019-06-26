import 'package:flutter/material.dart';
import 'package:movie_app_flutter/constants/global.dart';
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
  @override
  Widget build(BuildContext context) {
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
                  _buildMyList(context),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  // _buildPopularList(context),
                ],
              ),
            )),
      ),
    );
  }

  _buildMyList(BuildContext context) {
    print("tq8");
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("My Favorits",
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
            type: MovieListType.popular,
            onItemInteraction: (movieId) {
              _navigateToMovieDetail(context, movieId);
            },
          )
        ],
      ),
    );
  }

  _buildPopularList(BuildContext context) {}

  _navigateToMovieDetail(BuildContext context, int movieId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MovieDetails(
                  movieId: movieId,
                )));
  }
}
