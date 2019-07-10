import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moving/Repository/repo.dart';
import './carouselcontent.dart';
import './maintopratecontent.dart';

class mainPage extends StatefulWidget {
  @override
  _mainState createState() => _mainState();
}

class _mainState extends State<mainPage> {
  var nowplaying;
  var toprated;
  final repo = Repository();
  @override
  void initState() {
    super.initState();
    nowplaying = repo.reponowPlaying();
    toprated = repo.repotopRated();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              //constraints: BoxConstraints.expand(),
              child: FutureBuilder(
                  future: nowplaying,
                  builder: (context, asyncSnapshot) {
                    switch (asyncSnapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return CircularProgressIndicator();
                      case ConnectionState.done:
                        if (asyncSnapshot.hasError)
                          return Text('Error: ${asyncSnapshot.error}');
                        List list = asyncSnapshot.data.results;
                        return CarouselSlider(
                          items: list
                              .asMap()
                              .map((index, results) => MapEntry(
                                  index,
                                  Carouselcontent(
                                    title: results.title,
                                    poster:
                                        "https://image.tmdb.org/t/p/w500${results.posterPath}",
                                    back_drop:
                                        "https://image.tmdb.org/t/p/w500${results.backdropPath}",
                                    description: results.overview,
                                    vote_average: results.voteAverage,
                                  )))
                              .values
                              .toList(),
                          initialPage: 0,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlay: true,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          aspectRatio: 16 / 13,
                        );
                    }
                    // unreachable
                    //return null;
                  }),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(33, 25, 0, 0),
                  child: Row(
                    //mainAxisSize: MainAxisSize.max,

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Top Rated",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: FutureBuilder(
                    future: toprated,
                    builder: (context, asyncSnapshot) {
                      switch (asyncSnapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return CircularProgressIndicator();
                        case ConnectionState.done:
                          if (asyncSnapshot.hasError)
                            return Text('Error: ${asyncSnapshot.error}');
                          var list = asyncSnapshot.data.results;
                          print(list.length);
                          return ListView.builder(
                            itemCount: list.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, int index) {
                              return topRatedcontent(
                                poster:
                                    "https://image.tmdb.org/t/p/w500${list[index].posterPath}",
                                title: list[index].title,
                                description: list[index].overview,
                                vote_average: list[index].voteAverage,
                              );
                            },
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
          ]),
        ),
      ],
    );
  }
}
