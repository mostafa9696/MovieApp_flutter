import 'package:flutter/material.dart';
import 'package:movie_app_flutter/bloc/movie_images_bloc.dart';
import 'package:movie_app_flutter/model/movie_image_model.dart';

class MovieGallery extends StatefulWidget {

  final int movieId;
  MovieGallery({Key key, this.movieId}) : super(key: key);
  @override
  _MovieGalleryState createState() => _MovieGalleryState();

}

class _MovieGalleryState extends State<MovieGallery> {
  @override
  Widget build(BuildContext context) {
    movieImageBloc.fetchMovieImages(widget.movieId);
    return StreamBuilder(
      stream: movieImageBloc.movieImages,
        builder: (context, AsyncSnapshot<MovieImageModel> snapshot) {
          if (snapshot.hasData) {
            return buildContent(snapshot, context);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        }
    );
  }

  Widget buildContent(AsyncSnapshot<MovieImageModel> snapshot, BuildContext context) {
     var width = MediaQuery.of(context).size.width;
     return Container(
       height: width / 3,
       margin: EdgeInsets.only(bottom: 20, top: 10),
       child: ListView.builder(
           scrollDirection: Axis.horizontal,
           itemCount: 10,
           itemBuilder: (BuildContext context, int index) {
             return _buildItem(snapshot.data.posters[index].file_path, width / 3, index == 0);
           }),
     );

  }

  Widget _buildItem(String file_path, double height, bool isFirst) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      margin: EdgeInsets.only(left: isFirst ? 0 : 10, right: 10, bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Image.network('https://image.tmdb.org/t/p/w500$file_path',
        fit: BoxFit.cover,
        width: height * 4 / 3,
        height: height / 2,),
    );
  }

}