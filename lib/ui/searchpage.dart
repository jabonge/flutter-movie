import 'package:flutter/material.dart';
import 'package:moving/Bloc/searchBloc.dart';

class searchpage extends StatefulWidget {
  @override
  _searchpageState createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  @override
  void dispose() {
    // TODO: implement dispose
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
            child: TextField(
              decoration: InputDecoration(
                labelText: "  Search Movie",
              ),
              onChanged: (value) {
                bloc.onChange(value);
              },
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
          )
        ],
      ),
    );
  }
}
