import 'package:flutter/material.dart';
import 'package:movie_app/movie_widgets/11.now_playing.dart';
import 'package:movie_app/movie_widgets/12.get_genres.dart';
import 'package:movie_app/movie_widgets/15.movies_widget.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen>
    with AutomaticKeepAliveClientMixin {  //verileri yeniden yüklememesi icin
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return ListView(
      children: const <Widget>[
        NowPlaying(),
        GetGenres(),
        MoviesWidget(text: 'UPCOMING', request: 'upcoming'),
        MoviesWidget(text: 'POPULAR', request: 'popular'),
        MoviesWidget(text: 'TOP RATED', request: 'top_rated'),
      ],
    );
  }

  
}


