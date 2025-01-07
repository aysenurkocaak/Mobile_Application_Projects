import 'package:flutter/material.dart';
import 'package:movie_app/constant/style.dart';
import 'package:movie_app/model/hive_movie_model.dart';
import 'package:movie_app/model/movie/1.movie_model.dart';
import 'package:movie_app/movie_widgets/16.movie_info.dart';
import 'package:movie_app/movie_widgets/similar_movies.dart';
import 'package:movie_app/screens/17.reviews.dart';
import 'package:movie_app/screens/trailers_screen.dart';
import 'package:hive/hive.dart';

/*
Bu ekran, bir filmle ilgili bilgileri sunar, kullanıcıya film
 hakkında bilgi verir ve filmi izleme listesine eklemek
 veya listeden kaldırmak için seçenekler sunar.
*/
class MoviesDetailsScreen extends StatefulWidget {
  const MoviesDetailsScreen(
      {super.key, required this.movie, this.request, this.hiveId});
  final Movie movie;
  final String? request;
  final int? hiveId;

  @override
  State<MoviesDetailsScreen> createState() => _MoviesDetailsScreenState();
}

class _MoviesDetailsScreenState extends State<MoviesDetailsScreen> {
  late Box<HiveMovieModel> _movieWatchLists; //hive da saklanan film listesi

  bool _isMovieInWatchList(int id) { // film watch liste varmı yokmu
    final List<int> keys = _movieWatchLists.keys.cast<int>().toList();
    return keys.any((key) => _movieWatchLists.get(key)?.id == id);
  }

  @override
  void initState() {
    _movieWatchLists = Hive.box<HiveMovieModel>('movie_lists'); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        title: Text(
          widget.movie.title!,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildBackDrop(),
                Positioned(
                  top: 150,
                  left: 30,
                  child: Hero(
                    tag: widget.request == null
                        ? "${widget.movie.id}"
                        : "${widget.movie.id}${widget.request!}",
                    child: _buildPoster(),
                  ),
                ),
              ],
            ),
            MovieInfo(id: widget.movie.id!),
            SimilarMovies(id: widget.movie.id!),
            Reviews(
              id: widget.movie.id!,
              request: "movie",
            ),
          ],
        ),
      ),
      persistentFooterButtons: [ // film liste ekle veya sil iki buton icerir eklendiyse zaten eklendi mesajı
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 235, 5, 5),
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          TrailersScreen(shows: "movie", id: widget.movie.id!),
                    ));
                  },
                  icon: const Icon(
                    Icons.play_circle_fill_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Watch Trailers',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 255, 200, 0),
                child: TextButton.icon(
                  onPressed: () {
                    // Eğer film listede mevcutsa uyarı mesajını göster.
                    if (_isMovieInWatchList(widget.movie.id!)) {
                      _showAlertDialog(
                        title: "ALREADY IN YOUR LIST !!",
                        content:
                            "${widget.movie.title} is already in your Watch List!",
                      );
                    } else {
                      // Film listede mevcut değilse ekle ve başarı mesajını göster.
                      if (widget.hiveId == null) {
                        HiveMovieModel newValue = HiveMovieModel(
                          id: widget.movie.id!,
                          rating: widget.movie.rating!,
                          title: widget.movie.title!,
                          backDrop: widget.movie.backDrop!,
                          poster: widget.movie.poster!,
                          overview: widget.movie.overview!,
                        );
                        _movieWatchLists.add(newValue);
                        _showAlertDialog(
                          title: "Added to List",
                          content:
                              "${widget.movie.title!} has been successfully added to your watch list!",
                        );
                      }

                      // Eğer 'hiveId' mevcutsa (silme işlemi için) filmi listeden sil.
                      if (widget.hiveId != null) {
                        _movieWatchLists.deleteAt(widget.hiveId!);
                        Navigator.of(context).pop(true);
                      }
                    }
                  },
                  icon: Icon(
                    widget.hiveId == null
                        ? Icons.list_alt_outlined
                        : Icons.delete,
                    size: 30,
                    color: Colors.white,
                  ),
                  label: Text(
                    widget.hiveId == null ? 'Add To Lists' : 'Delete This',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPoster() {
    return Container(
      width: 120,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: NetworkImage(
            "https://image.tmdb.org/t/p/w200/${widget.movie.poster!}",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBackDrop() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
            image: NetworkImage(
              "https://image.tmdb.org/t/p/original/${widget.movie.backDrop!}",
            ),
            fit: BoxFit.cover),
      ),
    );
  }

  void _showAlertDialog({required String title, required String content}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 49, 13, 88),
          title: Text(
            title,
            style: const TextStyle(
                color: Style.secondColor,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          content: Text(
            content,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 9, 1, 29)),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(
                    color: Color.fromARGB(255, 243, 230, 1), fontSize: 16),
              ),
            )
          ],
        );
      },
    );
  }
}
