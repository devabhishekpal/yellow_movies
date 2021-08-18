import 'package:flutter/material.dart';
import 'package:yellow_movies/constants.dart';
import 'package:yellow_movies/helpers/database_helper.dart';
import 'package:yellow_movies/models/movie_info.dart';
import 'package:collection/collection.dart';

class MovieProvider with ChangeNotifier{
  List _items = [];

  List get items {
    return [..._items];
  }

  MovieInfo? getMovie(int id){
    return _items.firstWhereOrNull((movie) => movie.id == id);
  }

  Future addOrUpdateMovie(int id, String title, String director, String imagePath, EditMode editMode) async{
    final movie = MovieInfo(id, title, director, imagePath);
    if(editMode == EditMode.ADD){
      _items.insert(0, movie);
    }
    else{
      _items[_items.indexWhere((movie) => movie.id == id)] = movie;
    }
    notifyListeners();
    DatabaseHelper.insert({
      'id' : movie.id,
      'name': movie.name,
      'director': movie.director,
      'posterPath': movie.posterPath!
    });
  }

  Future getMovies() async{
    
    final moviesList = await DatabaseHelper.getMoviesFromDB();
    _items = moviesList.map(
            (item) => MovieInfo(
                item['id'], item['name'], item['director'], item['posterPath']
            )
    ).toList();
    notifyListeners();
  }

  Future deleteMovie(int id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    return DatabaseHelper.delete(id);
  }
}