class Movie {
  List<Results> results;
  num total_results;

  Movie({this.results, this.total_results});

  Movie.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
      total_results = json['total_results'];
    }
  }
}

class Results {
  int voteCount;
  int id;
  bool video;
  num voteAverage;
  String title;
  num popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<dynamic> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Results(
      {this.voteCount,
      this.id,
      this.video,
      this.voteAverage,
      this.title,
      this.popularity,
      this.posterPath,
      this.originalLanguage,
      this.originalTitle,
      this.genreIds,
      this.backdropPath,
      this.adult,
      this.overview,
      this.releaseDate});

  Results.fromJson(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    id = json['id'];
    video = json['video'];
    voteAverage = json['vote_average'];
    title = json['title'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'];
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }
}
