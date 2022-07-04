class Movie {
  int? id;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? title;
  dynamic voteAverage;

  Movie({
    this.id,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.title,
    this.voteAverage,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    title = json['title'];
    voteAverage = json['vote_average'];
  }
}
