import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/model/5.genres_model.dart';
import 'package:movie_app/model/movie/2.movie_details_model.dart';
import 'package:movie_app/model/movie/1.movie_model.dart';
import 'package:movie_app/model/6.reviews_model.dart';
import 'package:movie_app/model/7.trailers_model.dart';
import 'package:movie_app/model/tv/4.tv_details_model.dart';
import 'package:movie_app/model/tv/3.tv_model.dart';

/*
 HttpRequest sınıfı, Dio paketini kullanarak API çağrıları 
 yapan çeşitli HTTP isteklerini içerir. Bu istekler, film ve 
 TV şovları için türler, detaylar, yorumlar, fragmanlar, benzer 
 içerikler ve keşif gibi verileri almanızı sağlar. Her bir 
 fonksiyon, API'den veri çeker ve bu verileri belirli bir model 
 sınıfına (GenreModel, MovieModel, TVModel, vb.) dönüştürür.
*/


class HttpRequest {
  static final String? apiKey = dotenv.env['API_KEY'];// .env dosyaısndan alinan apikey
  static const String mainUrl = "https://api.themoviedb.org/3"; // tmdb ana url
  static final Dio dio = Dio();
  static var getGenreUrl = "$mainUrl/genre";
  static var getDiscoverUrl = "$mainUrl/discover";
  static var getMoviesUrl = "$mainUrl/movie";
  static var getTVUrl = "$mainUrl/tv";


//get genres:  kategorilere göre film veya
// dizileri listelemek
  static Future<GenreModel> getGenres(String shows) async {
    var params = {"api_key": apiKey, "language": "en-us", "page": 1};

    try {
      Response response =
          await dio.get("$getGenreUrl/$shows/list", queryParameters: params);
      return GenreModel.fromJson(response.data);
    } catch (error) {
      return GenreModel.withError("$error");
    }
  }

// get reviews: Uygulamanızda kullanıcı incelemelerini 
//göstermek istediğinizde bu fonksiyonu kullanırsınız. (yildiz vermek, tarih)
  static Future<ReviewsModel> getReviews(String shows, int id) async {
    var params = {"api_key": apiKey, "language": "en-us", "page": 1};

    try {
      Response response =
          await dio.get("$mainUrl/$shows/$id/reviews", queryParameters: params);
      return ReviewsModel.fromJson(response.data);
    } catch (error) {
      return ReviewsModel.withError("$error");
    }
  }

// get trailer
  static Future<TrailersModel> getTrailers(String shows, int id) async {
    var params = {"api_key": apiKey, "language": "en-us"};

    try {
      Response response =
          await dio.get("$mainUrl/$shows/$id/videos", queryParameters: params);
      return TrailersModel.fromJson(response.data);
    } catch (error) {
      return TrailersModel.withError("$error");
    }
  }

  //similar movies: Kullanıcıların ilgisini çekebilecek benzer 
  //içerikleri göstermek için kullanışlıdır.

  static Future<MovieModel> getSimilarMovies(int id) async {
    var params = {"api_key": apiKey, "language": "en-us", "page": 1};

    try {
      Response response =
          await dio.get("$getMoviesUrl/$id/similar", queryParameters: params);
      return MovieModel.fromJson(response.data);
    } catch (error) {
      return MovieModel.withError("$error");
    }
  }

  // similar tvs

  static Future<TVModel> getSimilarTVShows(int id) async {
    var params = {"api_key": apiKey, "language": "en-us", "page": 1};

    try {
      Response response =
          await dio.get("$getTVUrl/$id/similar", queryParameters: params);
      return TVModel.fromJson(response.data);
    } catch (error) {
      return TVModel.withError("$error");
    }
  }

  // discover movies: "Bilim Kurgu" türündeki filmleri 
  //listelemek için bu fonksiyonu kullanabilirsiniz

  static Future<MovieModel> getDiscoverMovies(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en-us",
      "page": 1,
      "with_genres": id,
    };

    try {
      Response response =
          await dio.get("$getDiscoverUrl/movie", queryParameters: params);

      print("API repsonse: ${response.data}");
      return MovieModel.fromJson(response.data);
    } catch (error) {
      print("Error: $error");
      return MovieModel.withError("$error");
    }
  }

// discover tvs
  static Future<TVModel> getDiscoverTVShows(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en-us",
      "page": 1,
      "with_genres": id,
    };

    try {
      Response response =
          await dio.get("$getDiscoverUrl/tv", queryParameters: params);
      return TVModel.fromJson(response.data);
    } catch (error) {
      return TVModel.withError("$error");
    }
  }

  // movie details: , kullanıcıya film veya dizinin özetini, 
  //yayın tarihini, türünü, afişini ve daha fazla detayı
  // göstermenizi sağlar.

  static Future<MovieDetailsModel> getMoviesDetails(int id) async {
    var params = {"api_key": apiKey, "language": "en-us"};

    try {
      Response response =
          await dio.get("$getMoviesUrl/$id", queryParameters: params);
      return MovieDetailsModel.fromJson(response.data);
    } catch (error) {
      return MovieDetailsModel.withError("$error");
    }
  }

  // tv show details

  static Future<TVDetailsModel> getTVShowsDetails(int id) async {
    var params = {"api_key": apiKey, "language": "en-us"};

    try {
      Response response =
          await dio.get("$getTVUrl/$id", queryParameters: params);
      return TVDetailsModel.fromJson(response.data);
    } catch (error) {
      return TVDetailsModel.withError("$error");
    }
  }

  // get movies with different requests
  // nowplaying, popular, toprated, upcoming
  static Future<MovieModel> getMovies(String request) async {
    var params = {"api_key": apiKey, "language": "en-us"};

    try {
      Response response =
          await dio.get("$getMoviesUrl/$request", queryParameters: params);
      return MovieModel.fromJson(response.data);
    } catch (error) {
      return MovieModel.withError("$error");
    }
  }

  // get tv
  static Future<TVModel> getTVShows(String request) async {
    var params = {"api_key": apiKey, "language": "en-us"};

    try {
      Response response =
          await dio.get("$getTVUrl/$request", queryParameters: params);
      return TVModel.fromJson(response.data);
    } catch (error) {
      return TVModel.withError("$error");
    }
  }
}

// api integrations ve json model bitti
