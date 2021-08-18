class MovieInfo {
  int _id;
  String _name;
  String _director;
  String? _posterPath;

  MovieInfo(this._id, this._name, this._director, this._posterPath);

  int get id => _id;
  String get name => _name;
  String get director => _director;
  String? get posterPath => _posterPath;
}