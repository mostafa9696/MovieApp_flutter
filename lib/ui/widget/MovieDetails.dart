import 'package:flutter/material.dart';
import 'package:movie_app_flutter/bloc/movie_details_bloc.dart';
import 'package:movie_app_flutter/model/movie_detail_model.dart';

class MovieDetails extends StatefulWidget {
  MovieDetails({Key key, this.movieId}) : super(key: key);
  final int movieId;

  @override
  State createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetails> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    movieDetailsBloc.fetchMovieDetails(widget.movieId);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildDetails(context),
          Positioned(
            // A widget that controls where a child of a [Stack] is positioned
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: Text("Movie App"),
              centerTitle: true,
              backgroundColor: Colors.lightGreen,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder(
          stream: movieDetailsBloc.movieDetails,
          builder: (context, AsyncSnapshot<MovieDetailModel> snapshoot) {
            if (snapshoot.hasData) {
              return _buildContent(snapshoot, context);
            } else if (snapshoot.hasError) {
              return Text(snapshoot.error.toString());
            }

            return Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }

  Widget _buildContent(
      AsyncSnapshot<MovieDetailModel> snapshoot, BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Column(
        children: <Widget>[
          _buildMovieImage(context, snapshoot.data.backdrop_path),
          Padding(
            padding: EdgeInsets.only(top: 24),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildMovieName(context, snapshoot.data.original_title),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMovieImage(BuildContext context, String backdrop_path) {
    var width = MediaQuery.of(context).size.width;
    print("wid" + width.toString());
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          width: width,
          height: width,
          child: Image.network('https://image.tmdb.org/t/p/w780$backdrop_path',
              fit: BoxFit.cover),
        ),


        Positioned(
            right: 20.0,
            top: width,
            child: FractionalTranslation(
              // top vertical translation by half of the height of the child.
              translation: Offset(0.0, -0.5),
              child: FloatingActionButton(
                onPressed: () {
                  // todo play movie trailer
                },
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.lightBlueAccent,
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildMovieName(BuildContext context, String name) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black87,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: "Muli"),
      ),
    );
  }
}
