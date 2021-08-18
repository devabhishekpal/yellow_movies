# yellow_movies

A Flutter project for Yellow Class.

## Getting Started

This project is a Movie Database App that allows users to:
* Login via Google Sign-in (Persistent)
* Add/Edit/Delete Movies
* View the movie list


## File Structure

### helpers
Contains the helpers to perform operations on the SQLite database

### models
Used to model the data in an ORM format

```
(MovieInfo) -> int id, String name, String director, String? posterPath (optional)
        
- posterPath -> stores the local path of the image file
- id -> unique indentifier for movie
```

### providers

```
- google_sign_in_provider -> Used for logging in and out of the app via Google Sign-In
- movie_provider -> Used to perform actions on the DB according to user response
```

### screens
Contains the various pages that is to be displayed

### widget
Subparts of the screens that are used like utilities

### Other files

main -> Contains the starting/entry of the app<br>
constants-> Stores constant values to refer in app