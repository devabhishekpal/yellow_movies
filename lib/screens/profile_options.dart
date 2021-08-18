import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yellow_movies/providers/google_signin_provider.dart';

class ProfileOptionsScreen extends StatefulWidget {
  static const route = '/profile-view';

  @override
  _ProfileOptionsScreenState createState() => _ProfileOptionsScreenState();
}

class _ProfileOptionsScreenState extends State<ProfileOptionsScreen> {

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Account",
              style: TextStyle(
                fontFamily: 'Oxygen',
                fontWeight: FontWeight.w800,
                fontSize: 25
              )
            ),
            SizedBox(height: 32),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            SizedBox(height: 20),
            Text(
              user.displayName!,
              style: TextStyle(
                  fontFamily: 'Sarabun',
                  fontWeight: FontWeight.w400,
                  fontSize: 16
              )
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFFE61C3F),
                  onPrimary: Color(0xFFB10025),
                  minimumSize: Size(70, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  )
              ),
              icon: FaIcon(FontAwesomeIcons.signOutAlt, color: Colors.white),
              label: Text(
                "Logout",
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
                provider.logout();
                Navigator.popUntil(context, ModalRoute.withName("/"));
              },
            ),
          ],
        ),
      ),
    );
  }
}
