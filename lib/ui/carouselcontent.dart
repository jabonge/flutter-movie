import 'package:flutter/material.dart';

class Carouselcontent extends StatelessWidget {
  Carouselcontent(
      {this.poster,
      this.title,
      description,
      this.vote_average,
      this.back_drop}) {
    if (description.length > 250) {
      this.description = description.substring(0, 220) + "...";
    } else {
      this.description = description;
    }
  }
  final String poster;
  final String back_drop;
  final String title;
  String description;
  final num vote_average;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken),
              image: NetworkImage(
                back_drop,
              ),
              fit: BoxFit.cover)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
              flex: 3,
              child: Image.network(
                poster,
                height: 300,
                fit: BoxFit.cover,
              )),
          Flexible(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 8,
                  ),
                  Text(
                    " $vote_average / 10",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    height: 8,
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
