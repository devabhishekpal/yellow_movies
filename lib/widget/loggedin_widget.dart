import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yellow_movies/screens/movie_edit_screen.dart';
import 'package:yellow_movies/screens/movie_list_screen.dart';
import 'package:yellow_movies/screens/profile_options.dart';

class LoggedInWidget extends StatefulWidget {
  const LoggedInWidget({Key? key}) : super(key: key);
  static const route = "/logged-in";
  @override
  _LoggedInWidgetState createState() => _LoggedInWidgetState();
}

class _LoggedInWidgetState extends State<LoggedInWidget> {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            IconButton(
              color: Colors.black54,
              icon: Icon(Icons.add_circle_outline),
              onPressed: () {
                Navigator.of(context).pushNamed(MovieEditScreen.route, arguments: {"id": null});
              },
            ),
            IconButton(
              color: Colors.black54,
              icon: Icon(Icons.person_outline_sharp),
              onPressed: () {
                Navigator.of(context).pushNamed(ProfileOptionsScreen.route);
              },
            )
          ]
        ),
        body: MovieListScreen()
    );
  }
}
