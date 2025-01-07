import 'package:flutter/material.dart';
import 'package:movie_app/constant/style.dart';
import 'package:movie_app/model/5.genres_model.dart';
import 'package:movie_app/tv_widgets/3.genre_tv.dart';

class GenreLists extends StatefulWidget {
  const GenreLists({super.key, required this.genres});
  final List<Genre> genres;

  @override
  State<GenreLists> createState() => _GenreListsState();
}

class _GenreListsState extends State<GenreLists>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: widget.genres.length, vsync: this);
    _tabController!.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: DefaultTabController(
        length: widget.genres.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(65),
            child: AppBar(
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Style.secondColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                unselectedLabelColor: Style.textColor,
                labelColor: Colors.white,
                isScrollable: true,
                tabs: widget.genres.map((Genre genre) {
                  return Container(
                    padding: const EdgeInsets.only(
                      bottom: 15,
                      top: 10,
                    ),
                    child: Text(
                      genre.name!.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: widget.genres.map((Genre genre) {
              return GenreTVs(genreId: genre.id!);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
