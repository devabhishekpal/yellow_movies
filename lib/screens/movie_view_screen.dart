import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yellow_movies/models/movie_info.dart';
import 'package:yellow_movies/providers/movie_provider.dart';
import 'package:yellow_movies/screens/movie_edit_screen.dart';
import 'package:yellow_movies/widget/delete_popup_widget.dart';

class MovieViewScreen extends StatefulWidget {
  static const route = "/view-movie";
  @override
  _MovieViewScreenState createState() => _MovieViewScreenState();
}

class _MovieViewScreenState extends State<MovieViewScreen> {
  MovieInfo? selectedMovie;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    final id = (ModalRoute.of(context)!.settings.arguments as Map)["id"];
    final provider = Provider.of<MovieProvider>(context);

    if(provider.getMovie(id) != null){
      selectedMovie = provider.getMovie(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () => _showDialog(),
              icon: Icon(Icons.delete, color: Colors.black54,)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Text(
                selectedMovie!.name,
                style: TextStyle(
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                    color: Color(0xFF181818),
                    decoration: TextDecoration.none
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                selectedMovie!.director,
                style: TextStyle(
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: Color(0xFF262626),
                    decoration: TextDecoration.none
                ),
              ),
            ),
            if(selectedMovie?.posterPath != '')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.file(File(selectedMovie!.posterPath!)),
              ),
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, MovieEditScreen.route, arguments: {"id": selectedMovie!.id});
          },
          child: Icon(Icons.edit, size: 30, color: Colors.black87,),
          backgroundColor: Colors.white,
        ),
    );
  }

  _showDialog() {
    showDialog(
        context: this.context,
        builder: (context) {
          return DeletePopUp(selectedMovie: selectedMovie!);
        });
  }
}
