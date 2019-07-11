import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moving/Repository/repo.dart';
import './carouselcontent.dart';
import './maintopratecontent.dart';
import './detailpage.dart';

class mainPage2 extends StatefulWidget {
  @override
  _mainState createState() => _mainState();
}

class _mainState extends State<mainPage2> {
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
    return FutureBuilder(
        future: nowplaying,
        builder: (context, asyncSnapshot1) {
          switch (asyncSnapshot1.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (asyncSnapshot1.hasError)
                return Text('Error: ${asyncSnapshot1.error}');
              return FutureBuilder(
                future: toprated,
                builder: (context, asyncSnapshot2) {
                  switch (asyncSnapshot2.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                      if (asyncSnapshot2.hasError)
                        return Text('Error: ${asyncSnapshot2.error}');
                      List list = asyncSnapshot1.data.results;
                      List list2 = asyncSnapshot2.data.results;
                      return CustomScrollView(slivers: <Widget>[
                        SliverList(
                            delegate: SliverChildListDelegate([
                          Column(
                            children: <Widget>[
                              CarouselSlider(
                                items: list
                                    .asMap()
                                    .map((index, results) => MapEntry(
                                        index,
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        detailpage(
                                                          results: results,
                                                        )));
                                          },
                                          child: Carouselcontent(
                                            title: results.title,
                                            poster:
                                                "https://image.tmdb.org/t/p/w500${results.posterPath}",
                                            back_drop:
                                                "https://image.tmdb.org/t/p/w500${results.backdropPath}",
                                            description: results.overview,
                                            vote_average: results.voteAverage,
                                          ),
                                        )))
                                    .values
                                    .toList(),
                                initialPage: 0,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlay: true,
                                viewportFraction: 1.0,
                                enlargeCenterPage: false,
                                aspectRatio: 16 / 11,
                              ),
                              Column(children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(33, 25, 0, 0),
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
                                ListView.builder(
                                  itemCount: list2.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    detailpage(
                                                      results: list2[index],
                                                    )));
                                      },
                                      child: topRatedcontent(
                                        poster:
                                            "https://image.tmdb.org/t/p/w500${list2[index].posterPath}",
                                        title: list2[index].title,
                                        description: list2[index].overview,
                                        vote_average: list2[index].voteAverage,
                                      ),
                                    );
                                  },
                                )
                              ])
                            ],
                          ),
                        ])),
                      ]);
                  }
                },
              );
          }
          // unreachable
          //return null;
        });
  }
}
