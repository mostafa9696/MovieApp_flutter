import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:movie_app_flutter/bloc/movie_details_bloc.dart';
import 'package:movie_app_flutter/db/DatabaseHelper.dart';
import 'package:movie_app_flutter/model/genre_model.dart';
import 'package:movie_app_flutter/model/movie_detail_model.dart';
import 'package:movie_app_flutter/model/production_country_model.dart';
import 'package:movie_app_flutter/ui/widget/MovieGallery.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieDetails extends StatefulWidget {
  MovieDetails({Key key, this.movieId, this.isFav}) : super(key: key);
  final int movieId;
  bool isFav;

  @override
  State createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetails> {
  bool isExpanded = false;
  DatabaseHelper db;

  @override
  void initState() {
    db = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    movieDetailsBloc.fetchMovieDetails(widget.movieId);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: _buildDetails(context),
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


  Widget _buildCollapseContent(
      AsyncSnapshot<MovieDetailModel> snapshoot, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: width / 2,
            floating: false,
            pinned: true,
            centerTitle: false,
            flexibleSpace: FlexibleSpaceBar(
              title: (Text(
                snapshoot.data.original_title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              )),
              background: _buildMovieImage(
                  context, snapshoot.data.backdrop_path, snapshoot.data.id),
            ),
          )
        ];
      },
      body: SingleChildScrollView(
        child: Container(
              color: Colors.black38,
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildMovieName(context, snapshoot.data.original_title),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  _buildGenres(context, snapshoot.data.genres),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  _buildRating(context, snapshoot.data.vote_average),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  _buildMovieInfo(
                    context,
                    snapshoot.data.release_date,
                    snapshoot.data.production_countries,
                    snapshoot.data.runtime,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  _buildMovieDescription(context, snapshoot.data.overview),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  _buildScreenShoots(context, snapshoot.data.id)
                ],
              ),
        ),
      ),
    );
  }


  Widget _buildContent(
      AsyncSnapshot<MovieDetailModel> snapshoot, BuildContext context) {
    return Container(
      color: Colors.white30,
      child: Column(
        children: <Widget>[
          _buildMovieImage(
              context, snapshoot.data.backdrop_path, snapshoot.data.id),
          Padding(
            padding: EdgeInsets.only(top: 24),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildMovieName(context, snapshoot.data.original_title),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                _buildGenres(context, snapshoot.data.genres),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                _buildRating(context, snapshoot.data.vote_average),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                _buildMovieInfo(
                  context,
                  snapshoot.data.release_date,
                  snapshoot.data.production_countries,
                  snapshoot.data.runtime,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                _buildMovieDescription(context, snapshoot.data.overview),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                _buildScreenShoots(context, snapshoot.data.id)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMovieImage(
      BuildContext context, String backdrop_path, int movieId) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          width: width,
          height: width,
          child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: 'https://image.tmdb.org/t/p/w780$backdrop_path', fit: BoxFit.cover,)
          //Image.network('https://image.tmdb.org/t/p/w780$backdrop_path',
            //  fit: BoxFit.cover),
        ),
        Positioned(
            right: 20.0,
            top: width,
            child: FractionalTranslation(
              // top vertical translation by half of the height of the child.
              translation: Offset(0.0, -0.5),
              child: FloatingActionButton(
                onPressed: () {
                  _toggleMovieFavorite(movieId, backdrop_path);
                },
                backgroundColor: Colors.white,
                child: Icon(
                  widget.isFav ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                  size: 40,
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

  Widget _buildGenres(BuildContext context, List<GenreModel> genres) {
    StringBuffer generesBuilder = StringBuffer();
    for (var genere in genres) {
      if (genere != null) {
        if (generesBuilder.length != 0) {
          generesBuilder.write(", ");
        }
        generesBuilder.write(genere.name);
      }
    }

    return Container(
      alignment: Alignment.center,
      child: Text(
        generesBuilder.toString(),
        style: TextStyle(
            color: Colors.black38, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRating(BuildContext context, double vote_average) {
    return Container(
      alignment: Alignment.center,
      child: StarRating(
        size: 25,
        rating: vote_average / 2,
        color: Colors.greenAccent,
        borderColor: Colors.black38,
        starCount: 5,
      ),
    );
  }

  _buildMovieInfo(BuildContext context, String release_date,
      List<ProductionCountryModel> production_countries, int runtime) {
    StringBuffer countriesBuilder = StringBuffer();
    for (var item in production_countries) {
      if (item != null) {
        if (countriesBuilder.length != 0) {
          countriesBuilder.write(", ");
        }

        countriesBuilder.write(item.id);
      }
    }
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
              child: buildMovieInfoItem(
                  "Year", release_date.substring(0, 4) ?? "")),
          Expanded(
              child: buildMovieInfoItem(
                  "Country", countriesBuilder.toString() ?? "")),
          Expanded(child: buildMovieInfoItem("Length", "$runtime min")),
        ],
      ),
    );
  }

  Widget buildMovieInfoItem(String header, String desc) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            header,
            style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Wrap(
            children: <Widget>[
              Text(
                desc,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Muli"),
              )
            ],
          )
        ],
      ),
    );
  }

  _buildMovieDescription(BuildContext context, String overview) {
    return GestureDetector(
      onTap: () {
        _expandOverview();
      },
      child: Container(
        alignment: Alignment.center,
        child: AnimatedCrossFade(
            firstChild: Text(overview,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black87, fontSize: 14.0, fontFamily: "Muli")),
            secondChild: Text(
              overview,
              style: TextStyle(
                  color: Colors.black87, fontSize: 14.0, fontFamily: "Muli"),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: kThemeAnimationDuration),
      ),
    );
  }

  void _expandOverview() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  Widget _buildScreenShoots(BuildContext context, int id) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Screenshots",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Muli"),
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.black,
              )
            ],
          ),
          MovieGallery(
            movieId: id,
          )
        ],
      ),
    );
  }

  void _toggleMovieFavorite(int movieId, String backdrop_path) async {
    if (widget.isFav) {
      db.deleteFav(movieId);
    } else {
      int z = await db.addFav(movieId, backdrop_path);
    }
    setState(() {
      widget.isFav = !widget.isFav;
    });
  }
}
