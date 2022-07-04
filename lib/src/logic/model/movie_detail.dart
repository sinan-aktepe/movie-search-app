class MovieDetail {
  int? id;
  String? overview;
  String? backdropPath;
  List<Genres>? genres;

  MovieDetail({
    this.id,
    this.backdropPath,
    this.genres,
    this.overview,
  });

  MovieDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    overview = json['overview'];
    backdropPath = json['backdrop_path'];
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(Genres.fromJson(v));
      });
    }
  }
}

class Genres {
  int? id;
  String? name;

  Genres({id, name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
