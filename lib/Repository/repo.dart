import '../api/api.dart';
import '../api/movie.dart';

class Repository {
  final api = MovieApi();
  Future<Movie> reponowPlaying() => api.nowPlaying();
  Future<Movie> repotopRated() => api.topRated();
  Future<Movie> repoSearch(String text) => api.searchMovie(text);
}
