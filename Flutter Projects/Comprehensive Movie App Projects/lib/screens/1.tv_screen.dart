import 'package:flutter/material.dart';
import 'package:movie_app/tv_widgets/airing_today_widget.dart';
import 'package:movie_app/tv_widgets/tv_widget.dart';
import 'package:movie_app/tv_widgets/5.get_genres.dart';

class TVsScreen extends StatefulWidget {
  const TVsScreen({super.key});

  @override
  State<TVsScreen> createState() => _TVsScreenState();
}

class _TVsScreenState extends State<TVsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: const <Widget>[
        AiringToday(),
        GetGenres(),
        TVsWidget(text: "UPCOMING", request: "on_the_air"),
        TVsWidget(text: "POPULAR", request: "popular"),
        TVsWidget(text: "TOP RATED", request: "top_rated"),
      ],
    );
  }
}
