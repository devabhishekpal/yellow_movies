import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:yellow_movies/models/movie_info.dart';
import 'package:yellow_movies/providers/movie_provider.dart';
import 'package:yellow_movies/screens/movie_list_screen.dart';
import 'package:yellow_movies/widget/loggedin_widget.dart';

import '../constants.dart';

class MovieEditScreen extends StatefulWidget {
  static const route = "/edit-movie";

  @override
  _MovieEditScreenState createState() => _MovieEditScreenState();
}

class _MovieEditScreenState extends State<MovieEditScreen> {

  final titleController = TextEditingController();
  final directorController = TextEditingController();
  final picker = ImagePicker();
  File? _image;

  bool firstTime = true;
  MovieInfo? selectedMovie;
  int? id;



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(firstTime){
      id = (ModalRoute.of(this.context)!.settings.arguments as Map)["id"];
      if(id != null) {
        selectedMovie =
            Provider.of<MovieProvider>(this.context, listen: false).getMovie(
                id!);

        titleController.text = selectedMovie!.name;
        directorController.text = selectedMovie!.director;

        if (selectedMovie?.posterPath != '') {
          _image = File(selectedMovie!.posterPath!);
        }
      }
    }
    firstTime = false;
  }

  @override
  void dispose(){
    titleController.dispose();
    directorController.dispose();
    super.dispose();
  }

  Widget header(){
    return Container(
        height: 75.0,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.4,
        leading:  Padding(
          padding: EdgeInsets.only(left: 12.0, top: 15.0),
          child: Text(
            (id != null) ? "Edit" : "Add",
            style: TextStyle(
                fontFamily: 'Oxygen',
                fontWeight: FontWeight.w800,
                fontSize: 23.2,
                color: Color(0xFF262626)
            ),
          ),
        ),
        actions: [
          IconButton(
              color: Colors.black54,
              icon: Icon(Icons.photo_camera),
              onPressed: () {
                getImage(ImageSource.camera);
              },
          ),
          IconButton(
            color: Colors.black54,
            icon: Icon(Icons.insert_photo),
            onPressed: () {
              getImage(ImageSource.gallery);
            },
          ),
          IconButton(
            color: Colors.black54,
            icon: Icon(Icons.save),
            onPressed: (){
              if(titleController.text.isEmpty)
                titleController.text = 'Untitled Movie';
              saveMovie();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 15.0, right: 5.0, top: 10.0, bottom: 5.0),
              child: TextField(
                controller: titleController,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w800,
                    fontSize: 28
                ),
                decoration: InputDecoration(hintText: 'Enter Movie Title', border: InputBorder.none),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 5.0, top: 10.0, bottom: 5.0),
              child: TextField(
                controller: directorController,
                maxLines: null,
                style: TextStyle(
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.w400,
                    fontSize: 20
                ),
                decoration: InputDecoration(
                  hintText: 'Enter Director\'s name...',
                  border: InputBorder.none,
                ),
              ),
            ),
            if(_image != null)
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                height: 250.0,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover
                        )
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(
                                    () {
                                  _image = null;
                                });
                            },
                            child: Icon(
                              Icons.delete,
                              size: 16.0,
                            ),
                          ),
                        ),
                      )
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  getImage(ImageSource imageSrc) async {
    
    XFile? imageFile = await picker.pickImage(source: imageSrc);
    if(imageFile == null) return;
    File tmpFile = File(imageFile.path);
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imageFile.path);
    tmpFile = await tmpFile.copy('${appDir.path}/$fileName');

    setState(() {
      _image = tmpFile;
    });
  }

  void saveMovie() {
    String title = titleController.text.trim();
    String director = directorController.text.trim();
    String imagePath = _image != null ? _image!.path : "";

    if(id != null){
      Provider.of<MovieProvider>(this.context, listen: false).addOrUpdateMovie(id!, title, director, imagePath, EditMode.UPDATE);
      Navigator.of(this.context).pushReplacementNamed(LoggedInWidget.route, arguments: {"id": id});
    }
    else{
      int id = DateTime.now().millisecondsSinceEpoch;

      Provider.of<MovieProvider>(this.context, listen: false).addOrUpdateMovie(id, title, director, imagePath, EditMode.ADD);
      Navigator.of(this.context).pushReplacementNamed(LoggedInWidget.route, arguments: {"id": id});
    }
  }
}
