import 'dart:async';
import 'package:moving/api/movie.dart';
import 'package:rxdart/rxdart.dart';

import '../Repository/repo.dart';

class SearchBloc {
  // StreamController<String> _searchtext = StreamController();
  // StreamController<int> _future = StreamController();

  // Stream<String> get textstream => _searchtext.stream;
  // Stream<int> get moviestream => _future.stream;
  // Function(String) get textadd => _searchtext.sink.add;

  final _searchtext = PublishSubject<String>();
  final _future = BehaviorSubject<int>();

  Observable<String> get textstream => _searchtext.stream;
  Function(String) get textadd => _searchtext.sink.add;
  Observable<int> get moviestream => _future.stream;

  final repo = Repository();

  transformer() => new StreamTransformer<String, int>.fromHandlers(
          handleData: (value, sink) async {
        print(value);
        var movie = await repo.repoSearch(value);

        sink.add(count(movie));
      });
  //Stream get futurestr => Stream.fromFuture(getTotal(text));
  SearchBloc() {
    textstream.transform(transformer()).pipe(_future);
    // _searchtext.transform(transformer()).pipe(_future);
    //moviestream.listen((data) => data);
  }

  void dispose() {
    _searchtext.close();
    _future.close();
  }

  int count(Movie movie) {
    return movie.total_results;
  }

  void onChange(text) {
    textadd(text);
  }

  // Future<Movie> getTotal(String text) {
  //   return repo.repoSearch(text);
  // }

}

final bloc = SearchBloc();
