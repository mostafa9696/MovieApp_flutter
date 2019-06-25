import 'package:flutter/material.dart';
import 'package:movie_app_flutter/ui/widget/SlideShow.dart';
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
        backgroundColor: Colors.lightGreen,
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
                ],
              ),
            )),
      ),
    );
  }
}

_navigateToMovieDetail(BuildContext context, int movieId) {}
