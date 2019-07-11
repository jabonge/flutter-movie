import 'package:flutter/material.dart';
import 'package:moving/Bloc/searchBloc.dart';
import 'package:moving/ui/maintopratecontent.dart';

class searchpage extends StatefulWidget {
  @override
  _searchpageState createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  var bloc;
  @override
  void initState() {
    super.initState();
    bloc = SearchBloc();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width - 16,
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "  Search Movie", icon: Icon(Icons.search)),
                    onChanged: (value) {
                      bloc.onChange(value);
                    },
                    onSubmitted: (value) {
                      print(value);
                      if (value != null) bloc.submit(value);
                    },
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream: bloc.moviestream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text("${snapshot.data}개 결과");
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Text("0개의 결과");
            },
          ),
          Expanded(
            child: StreamBuilder(
              stream: bloc.searchmovie,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.results.length,
                    itemBuilder: (context, index) {
                      return topRatedcontent(
                        description: snapshot.data.results[index].overview,
                        poster:
                            "https://image.tmdb.org/t/p/w500${snapshot.data.results[index].posterPath}",
                        vote_average: snapshot.data.results[index].voteAverage,
                        title: snapshot.data.results[index].title,
                      );
                    },
                  );
                } else {
                  return Text("");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
