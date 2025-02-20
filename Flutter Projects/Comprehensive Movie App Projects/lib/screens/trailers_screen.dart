import 'package:movie_app/http/8.http_request.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/7.trailers_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailersScreen extends StatefulWidget {
  const TrailersScreen({super.key, required this.shows, required this.id});
  final String shows;
  final int id;

  @override
  State<TrailersScreen> createState() => _TrailersScreenState();
}

class _TrailersScreenState extends State<TrailersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<TrailersModel>(
        future: HttpRequest.getTrailers(widget.shows, widget.id),
        builder: (context, AsyncSnapshot<TrailersModel> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.error != null &&
                snapshot.data!.error!.isNotEmpty) {
              return _buildErrorWidget(snapshot.data!.error);
            }
            return _buildTrailersWidget(snapshot.data!);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return const Center();
  }

  //display error
  Widget _buildErrorWidget(dynamic error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Something is wrong : $error',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTrailersWidget(TrailersModel data) {
    List<Video>? videos = data.trailers;
    return Stack(
      children: <Widget>[
        Center(
          child: YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: videos![0].key!,
              flags: const YoutubePlayerFlags(
                hideControls: true,
                autoPlay: true,
              ),
            ),
          ),
        ),
        //close button
        Positioned(
          top: 40,
          right: 20,
          child: IconButton(
            icon: const Icon(Icons.close_sharp),
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }
}
