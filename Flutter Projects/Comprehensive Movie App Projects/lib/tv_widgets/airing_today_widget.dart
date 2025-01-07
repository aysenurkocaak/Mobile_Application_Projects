import 'package:flutter/material.dart';
import 'package:movie_app/constant/style.dart';
import 'package:movie_app/http/8.http_request.dart';
import 'package:movie_app/model/tv/3.tv_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class AiringToday extends StatefulWidget {
  const AiringToday({super.key});

  @override
  State<AiringToday> createState() => _AiringTodayState();
}

class _AiringTodayState extends State<AiringToday> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // webde de calisip calismadıgını kontrol ediyo
    final bool isWeb = kIsWeb;

    // 
    final double height = isWeb ? screenHeight * 0.6 : screenHeight * 0.35;
    final double imageScale = isWeb ? 0.95 : 0.95; // Adjust as needed

    return FutureBuilder<TVModel>(
      future: HttpRequest.getTVShows("airing_today"),
      builder: (context, AsyncSnapshot<TVModel> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != null &&
              snapshot.data!.error!.isNotEmpty) {
            return _buildErrorWidget(snapshot.data!.error);
          }
          return _buildAiringTodayWidget(snapshot.data!, height, imageScale);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(
      
    );
  }

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

  Widget _buildAiringTodayWidget(
      TVModel data, double height, double imageScale) {
    List<TVShows>? tvShows = data.tvShows;
    final PageController _pageController = PageController(
        viewportFraction: 0.8); // viewportFraction değerini ayarladık

    if (tvShows == null || tvShows.isEmpty) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: height,
        child: const Center(
          child: Text(
            'No TV Shows found',
            style: TextStyle(
              fontSize: 20,
              color: Style.textColor,
            ),
          ),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: height,
            child: PageView.builder(
              controller: _pageController,
              itemCount: tvShows.take(5).length,
              itemBuilder: (context, index) {
                return Transform(
                  transform: Matrix4.identity()
                    ..scale(imageScale, 1.0, imageScale),
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: height,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10), // Added margin
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://image.tmdb.org/t/p/original${tvShows[index].backDrop!}",
                            ),
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Style.primaryColor.withOpacity(1),
                              Style.primaryColor.withOpacity(0),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: const [0.0, 0.9],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 30.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                tvShows[index].name!,
                                style: const TextStyle(
                                  height: 1.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          SmoothPageIndicator(
            controller: _pageController,
            count: tvShows.take(5).length,
            effect: const ExpandingDotsEffect(
              activeDotColor: Style.secondColor,
              dotColor: Style.textColor,
              dotHeight: 10,
              dotWidth: 10,
            ),
          ),
        ],
      );
    }
  }
}
