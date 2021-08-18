import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yellow_movies/providers/movie_provider.dart';
import 'package:yellow_movies/widget/list_item_widget.dart';

class MovieListScreen extends StatelessWidget {
  static const route = "/list-movie";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<MovieProvider>(context, listen: false).getMovies(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        else{
          if(snapshot.connectionState == ConnectionState.done){
            return Scaffold(
              body: Consumer<MovieProvider>(
                child: noMoviesScreen(context),
                builder: (context, movieprovider, child) =>
                  movieprovider.items.length <= 0 ? 
                  child! :
                  ListView.builder(
                    itemCount: movieprovider.items.length + 1,
                    itemBuilder: (context, index){
                      if(index == 0) return header();
                      else{
                        final i = index - 1;
                        final item = movieprovider.items[i];

                        return ListItem(item.id, item.name, item.director, item.posterPath);
                      }
                    },
                  )
              ),
            );
          }
        }
        return Container();
      }
    );
  }

  Widget header(){
    return Container(
      height: 70.0,
      width: double.infinity,
      child: Padding(
        child: Text(
            'Movies',
            style: TextStyle(
                fontFamily: 'Oxygen',
                fontWeight: FontWeight.w800,
                fontSize: 28
            )
        ),
        padding: EdgeInsets.only(left: 20.0, top: 12.0),
      )
    );
  }

  Widget noMoviesScreen(BuildContext context){
    return ListView(
      children: [
        header(),
        Padding(
          padding: EdgeInsets.only(top: 5.0, left: 20.0),
          child: Text(
              "Oh no..\nFeels empty in here",
              style: TextStyle(
                  fontFamily: 'Sarabun',
                  fontWeight: FontWeight.w400,
                  fontSize: 16
              )
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Image.asset("assets/images/doggo.png"),
        )
      ]
    );
  }
}
