import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:yellow_movies/screens/movie_view_screen.dart';

class ListItem extends StatelessWidget {

  final int id;
  final String title;
  final String director;
  final String? posterPath;

  final gradients = [
    LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF84BEF1), Color(0xFF7EA2F7)]
    ),
    LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFCF86DF), Color(0xFFC33881)]
    ),
    LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFF5AF65), Color(0xFFEF9E5C)]
    ),
    LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFEE638E), Color(0xFFDB5C75)]
    ),
  ];//Choose random gradient for the list view boxes

  final _random = new Random();
  
  ListItem(this.id, this.title, this.director, this.posterPath);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 135.0,
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, MovieViewScreen.route, arguments: {"id": id});
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            gradient: gradients[_random.nextInt(gradients.length)],
            boxShadow: [BoxShadow(
              color: Color(0xFFBBBBBBFF),
              blurRadius: 30,
              offset: Offset(0, 10),
            )],
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              children: [
                if(posterPath != '')
                  Row(
                    children: [
                      SizedBox(width: 12.0),
                      Container(
                          width: 80.0,
                          height: 95.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            image: DecorationImage(image: FileImage(File(posterPath!)), fit: BoxFit.cover),
                          )
                        )
                      ],
                    ),
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 22.0,
                              fontFamily: 'Oxygen',
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFFFFFFF)
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Expanded(
                            child: Text(
                              director,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Sarabun',
                                  fontWeight: FontWeight.w100,
                                  color: Color(0xFFFFFFFF)
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
