import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yellow_movies/models/movie_info.dart';
import 'package:yellow_movies/providers/movie_provider.dart';

class DeletePopUp extends StatelessWidget {
  const DeletePopUp({Key? key, required this.selectedMovie}) : super(key: key);
  final MovieInfo selectedMovie;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text('Delete?'),
      content: Text('Do you want to delete the note?'),
      actions: [
        TextButton(
          child: Text('Yes'),
          onPressed: () {
            Provider.of<MovieProvider>(context, listen: false).deleteMovie(selectedMovie.id);
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
        TextButton(
          child: Text('No'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}