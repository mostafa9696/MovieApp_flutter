import 'package:flutter/material.dart';
import 'package:movie_app_flutter/ui/MovieHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MovieApp",
      home: MovieHomePage(),
    );
  }
}


