import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yellow_movies/widget/loggedin_widget.dart';
import 'package:yellow_movies/widget/signup_widget.dart';
class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
        backgroundColor: Color(0xFF101010),
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasData){
              return LoggedInWidget();
            }
            else if(snapshot.hasError){
              return Center(child: Text(
                'Something went wrong',
                style: TextStyle(
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                    color: Colors.white,
                    decoration: TextDecoration.none
                ),
              ));
            }
            return SignupWidget();
          },
        )
    );
  }
}