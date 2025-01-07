

class GenreModel {
  final List<Genre>? genres; //genre nesnelerinden olusan bi liste
  final String? error;

  GenreModel({this.genres, this.error});

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        genres: (json["genres"] as List)
            .map((genre) => Genre.fromJson(genre))
            .toList(),
        error: "",
      );

  factory GenreModel.withError(String error) => GenreModel(
        genres: [],
        error: error,
      );
}

// film türlerindekilerin özellikleri  json formatını genre nesnesine döndür
class Genre {
  int? id;
  String? name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json['id'],
        name: json['name'],
      );
}

/*
GenreModel ve Genre class'ları, film veya TV şovlarının 
türlerini (genre) modellemek için kullanılıyor. Bu class'lar,
 API'den gelen JSON verilerini alıp, türleri temsil eden Genre
  nesnelerine dönüştürüyor
 */