import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cozymovies/data.dart';
import 'package:cozymovies/model.dart';
import 'api.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  ApiKey apiKey;
  int moviesCount;
  List moviePage;

  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar = Text('Фильмы и сериалы');

  final String iconBase = 'https://images.tmdb.org/t/p/w92/';

  Future initialize() async {
    moviePage = List();
    moviePage = await apiKey.getUpcoming();
    setState(() {
      moviesCount = moviePage.length;
      moviePage = moviePage;
    });
  }

  @override
  void initState() {
    apiKey = ApiKey();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
        appBar: AppBar(
          title: searchBar,
          actions: <Widget>[
            IconButton(
                icon: visibleIcon,
                onPressed: () {
                  setState(() {
                    if (this.visibleIcon.icon == Icons.search) {
                      this.searchBar = TextField(
                        textInputAction: TextInputAction.search,
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                        onSubmitted: (String text) {
                          search(text);
                        },
                      );
                    }
                  });
                })
          ],
        ),
        body: ListView.builder(
            itemCount: (moviesCount == null) ? 0 : moviesCount,
            itemBuilder: (BuildContext context, int position) {
              if (moviePage[position].posterPath != null) {
                image = NetworkImage(iconBase +
                    moviePage[position]
                        .posterPath); //ввывод картинки по позиции
              }

              return GestureDetector(
                  //Маршрут
                  onTap: () {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (_) => MovieDetail(moviePage[position]));
                    Navigator.push(context, route);
                  },
                  child: Container(
                    // Контейнер для аватара
                    height: 150,
                    child: Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 4),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                child: Image(
                                  image: NetworkImage(image.url),
                                  fit: BoxFit.fitHeight,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(400)),
                              ),
                              flex: 2,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2, right: 10),
                                      child: Text(
                                        'Название:' "\n" +
                                            moviePage[position].title,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 2, right: 8),
                                        child: Text(
                                          'Дата выхода' "\n" +
                                              moviePage[position].releaseDate,
                                          style: TextStyle(
                                              fontSize: 7,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
            }));
  }

  Future search(text) async {
    List result = await apiKey.findMovies(text);
    setState(() {
      moviesCount = result.length;
      moviePage = result;
    });
  }
}
