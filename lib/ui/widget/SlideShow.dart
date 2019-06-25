import 'package:flutter/material.dart';
import 'package:movie_app_flutter/bloc/movie_list_bloc.dart';
import 'package:movie_app_flutter/constants/global.dart';
import 'package:movie_app_flutter/model/item_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SlidShowView extends StatefulWidget {
  final Function(int movieId) onItemClick;

  const SlidShowView({Key key, this.onItemClick}) : super(key: key);

  @override
  State createState() => _SlideShowViewState();
}

class _SlideShowViewState extends State<SlidShowView> {
  @override
  Widget build(BuildContext context) {
    movieListBloc.fetchMovieList(MovieListType.nowPlaying);
    return StreamBuilder(
      stream: movieListBloc.movieList,
      builder: (context, AsyncSnapshot<ItemModel> snapShot) {
        if (snapShot.hasData) {
          return buildContent(snapShot, context);
        } else {
          return Text(snapShot.error.toString());
        }
      },
    );
  }

  Widget buildContent(AsyncSnapshot<ItemModel> snapShot, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: CarouselSlider(
        height: width / 2,
        aspectRatio: 16 / 9,
        viewportFraction: 0.7,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 4),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        pauseAutoPlayOnTouch: Duration(seconds: 10),
        enlargeCenterPage: true,
        items: snapShot.data.results.map((movieItem) {
          // map each item to build its UI and handle onClick on it
          return Builder(
            builder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  if (widget.onItemClick != null) {
                    print("Movie click" + movieItem.title);
                    widget.onItemClick(movieItem.id);
                  } else {
                    debugPrint("No handle");
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: _buildMovieItem(
                      movieItem.backdrop_path, movieItem.original_title),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMovieItem(String imagePath, String title) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 8,
      //margin: EdgeInsets.only(left: 5, right: 5, bottom: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      // LayoutBuilder used when when do not know the space we have it give box constraint with min,max width&height to decide how to create view debend on it
      // Make UI responsive for different swcreen sizes (EX: mobile and tab mode in MovieApp list)
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: <Widget>[
            Image.network(
              "https://image.tmdb.org/t/p/w500$imagePath",
              fit: BoxFit.cover,
              height: constraints.biggest.height,
              width: constraints.biggest.width,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              height: constraints.biggest.height,
              width: constraints.biggest.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    Color(0x00000000),
                    Color(0x00000000),
                    Color(0x22000000),
                    Color(0x66000000),
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  title?.toUpperCase() ?? "",
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
        );
      }),
    );
  }
}
