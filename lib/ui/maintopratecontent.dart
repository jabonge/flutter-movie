import 'package:flutter/material.dart';

class topRatedcontent extends StatelessWidget {
  topRatedcontent({
    this.poster,
    this.title,
    description,
    this.vote_average,
  }) {
    if (description.length > 150) {
      this.description = description.substring(0, 150) + "...";
    } else {
      this.description = description;
    }
  }
  final String poster;
  final String title;
  String description;
  final num vote_average;
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 235,
      //decoration: BoxDecoration(border: Border.all()),
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: SizedBox(
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.network(
                      poster,
                      height: 190,
                      fit: BoxFit.cover,
                    ),
                  ],
                )),
            Flexible(
              flex: 4,
              child: Container(
                //decoration: BoxDecoration(border: Border.all()),
                margin: EdgeInsets.only(left: 15.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 7,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 15.0,
                        ),
                        Text(
                          " $vote_average / 10",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 7,
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
