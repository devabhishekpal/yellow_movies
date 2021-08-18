import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yellow_movies/providers/google_signin_provider.dart';
import 'package:yellow_movies/providers/movie_provider.dart';
import 'package:yellow_movies/screens/home_screen.dart';
import 'package:yellow_movies/screens/movie_edit_screen.dart';
import 'package:yellow_movies/screens/movie_list_screen.dart';
import 'package:yellow_movies/screens/movie_view_screen.dart';
import 'package:yellow_movies/screens/profile_options.dart';
import 'package:yellow_movies/widget/loggedin_widget.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider.value(value: MovieProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Yellow Movies',
        initialRoute: "/",
        routes: {
          "/": (context) => HomeScreen(),
          LoggedInWidget.route: (context) => LoggedInWidget(),
          MovieEditScreen.route: (context) => MovieEditScreen(),
          MovieViewScreen.route: (context) => MovieViewScreen(),
          ProfileOptionsScreen.route: (context) => ProfileOptionsScreen(),
          MovieListScreen.route: (context) => MovieListScreen()
        },
      ),
    );
  }
}