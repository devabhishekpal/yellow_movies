import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yellow_movies/providers/google_signin_provider.dart';

class SignupWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            SizedBox(height: 8.0,),
            Image.asset("assets/images/yellowMovies.png", height: 200, width: 200),
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Welcome to",
                style: TextStyle(
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.white,
                    decoration: TextDecoration.none
                )
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  "Yellow Movies",
                  style: TextStyle(
                      fontFamily: 'Oxygen',
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      color: Colors.white,
                      decoration: TextDecoration.none
                  )
              ),
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Please login to continue",
                style: TextStyle(
                  fontFamily: 'Sarabun',
                  fontWeight: FontWeight.w100,
                  fontSize: 15,
                  color: Colors.white,
                  decoration: TextDecoration.none
                )
              ),
            ),
            Spacer(),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFE61C3F),
                  onPrimary: Color(0xFFB10025),
                  minimumSize: Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                  )
                ),
                icon: FaIcon(FontAwesomeIcons.google, color: Colors.white),
                label: Text(
                    "Sign in with Google",
                    style: TextStyle(
                        fontFamily: 'Sarabun',
                        fontWeight: FontWeight.w100,
                        fontSize: 13,
                        color: Colors.white,
                        decoration: TextDecoration.none
                    ),
                ),
                onPressed: () {
                  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin();
                },
            ),
            SizedBox(height: 30),
            // RichText(
            //     text:TextSpan(
            //       style: TextStyle(fontSize: 12),
            //       text: "Already have an account?\t",
            //       children: [
            //         TextSpan(
            //           text: "Sign in",
            //           style: TextStyle(
            //             fontFamily: 'Oxygen',
            //             fontWeight: FontWeight.w400,
            //             decoration: TextDecoration.underline
            //           )
            //         )
            //       ]
            //     )
            // )
          ],
        ),
    );
  }
}