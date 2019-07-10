import 'package:http/http.dart' as http;
import 'dart:async';
import 'movie.dart';
import 'dart:convert';

class MovieApi {
  final API_KEY = "90d94bedc91588266f2813deba3425ae";
  final URL = "https://api.themoviedb.org/3/movie/";

  Future<Movie> nowPlaying() async {
    var now = await http
        .get('${URL}now_playing?api_key=$API_KEY')
        .then((res) => json.decode(res.body))
        .then((obj) => Movie.fromJson(obj));

    return now;
  }

  Future<Movie> topRated() async {
    var top = await http
        .get('${URL}top_rated?api_key=$API_KEY')
        .then((res) => json.decode(res.body))
        .then((obj) => Movie.fromJson(obj));
    //print(top);
    return top;
  }

  Future<Movie> searchMovie(String text) async {
    var search = await http
        .get(
            "https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&query=$text")
        .then((res) => json.decode(res.body))
        .then((obj) => Movie.fromJson(obj));
    //print(search.total_results);
    return search;
  }
}
