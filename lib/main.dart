import 'package:flutter/material.dart';
import 'movie_page.dart';

void main() {
  runApp(Movies());
}

class Movies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Фильмы и сериалы',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MoviePage();
  }
}
