import 'package:flutter/material.dart';
import 'package:movie_app/constant/style.dart';
import 'package:movie_app/model/tv/3.tv_model.dart';
import 'package:movie_app/screens/2.tv_details_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/model/hive_tv_model.dart';

class TVWatchLists extends StatefulWidget {
  const TVWatchLists({super.key});

  @override
  State<TVWatchLists> createState() => _TVWatchListsState();
}

class _TVWatchListsState extends State<TVWatchLists> {
  late Box<HiveTVModel> _tvWatchLists;

  @override
  void initState() {
    _tvWatchLists = Hive.box<HiveTVModel>('tv_lists');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _tvWatchLists.isEmpty
          ? const Center(
              child: Text(
                "No TV shows added to list yet!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Style.textColor,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ValueListenableBuilder(
                    valueListenable: _tvWatchLists.listenable(),
                    builder: (context, Box<HiveTVModel> item, _) {
                      List<int> keys = item.keys.cast<int>().toList();
                      return ListView.builder(
                        itemCount: keys.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final key = keys[index];
                          final HiveTVModel? _item = item.get(key);
                          return Card(
                            elevation: 5,
                            color: const Color.fromARGB(192, 244, 231, 253)
                                .withOpacity(0.9),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 7),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              onTap: () async {
                                TVShows _tvShows = TVShows();
                                _tvShows.id = _item!.id;
                                _tvShows.name = _item.name;
                                _tvShows.overview = _item.overview;
                                _tvShows.backDrop = _item.backDrop;
                                _tvShows.poster = _item.poster;
                                _tvShows.rating = _item.rating;

                                final refresh = await Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return TVsDetailsScreen(
                                    tvShows: _tvShows,
                                    hiveId: index,
                                  );
                                }));

                                if (refresh) {
                                  setState(() {});
                                }
                              },
                              title: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _item!.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 60, 19, 113),
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                _item.overview,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                selectionColor: Colors.amber,
                              ),
                              leading: Image.network(
                                "https://image.tmdb.org/t/p/w200/${_item.poster}",
                                fit: BoxFit.cover,
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    _tvWatchLists.deleteAt(index);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
