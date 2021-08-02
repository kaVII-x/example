class Movie {
  String title;
  String releaseDate;
  String overview;
  String posterPath;

  Movie(this.title, this.overview, this.posterPath, this.releaseDate);

  Movie.fromJson(Map<String, dynamic> parsedJson) {
    this.title = parsedJson['title'];
    this.releaseDate = parsedJson['release_date'];
    this.overview = parsedJson['overview'];
    this.posterPath = parsedJson['poster_path'];
  }
}
