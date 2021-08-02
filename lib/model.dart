import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:like_button/like_button.dart';

import 'package:cozymovies/data.dart';

import 'data.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  final String iconBase = 'https://images.tmdb.org/t/p/w500/';
  String path;

  MovieDetail(this.movie);

  @override
  Widget build(BuildContext context) {
    if (movie.posterPath != null) {
      path = iconBase + movie.posterPath; // Развертка выделенного изабражения
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(16), child: Image.network(path)),
              Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Text('О фильме:' "\n" + movie.overview),
              ),
              LikeButton(
                size: 50.0,
                circleColor: CircleColor(start: Colors.red, end: Colors.black),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: Colors.red,
                  dotSecondaryColor: Colors.black,
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.favorite,
                    color: isLiked ? Colors.blueAccent : Colors.black,
                    size: 50.0,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
