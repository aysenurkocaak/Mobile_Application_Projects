import 'package:flutter/material.dart';
import 'package:movie_app/model/movie/1.movie_model.dart';
import 'package:movie_app/constant/style.dart';
import 'package:movie_app/http/8.http_request.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key});

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  final PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    // uyg webde calisirmi claismazmı kontrol
    final bool isWeb = kIsWeb;

    
    final double height = isWeb ? screenHeight * 0.6 : screenHeight * 0.35;
    final double imageScale = isWeb ? 0.95 : 0.95; 

    return FutureBuilder<MovieModel>(
      future: HttpRequest.getMovies("now_playing"),
      builder: (context, AsyncSnapshot<MovieModel> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != null &&
              snapshot.data!.error!.isNotEmpty) {
            return _buildErrorWidget(snapshot.data!.error);
          }
          return _buildNowPlayingWidget(snapshot.data!, height, imageScale); // veri yüklendiyse data paramt. ile nowplayimg olussun
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error); // hata olursa hata mess
        } else {
          return _buildLoadingWidget(); // yüklenmemisse
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return const Center();
  }

  Widget _buildErrorWidget(dynamic error) {
    return Center(
      child: Text(
        'Something is wrong : $error',
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildNowPlayingWidget(
      MovieModel data, double height, double imageScale) {
    List<Movie>? movies = data.movies;

    if (movies == null || movies.isEmpty) {
      return const Center(
        child: Text(
          'No Movies found',
          style: TextStyle(
            fontSize: 20,
            color: Style.textColor,
          ),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: height,
            child: PageView.builder( // sayfalar arası kaydırma işlemi
              controller: _pageController,
              itemCount: movies.take(5).length, // görüntülencek öge ayısı
              itemBuilder: (context, index) {
                return Transform( // yatay ve dikeyde ölçeklendirme
                  transform: Matrix4.identity()
                    ..scale(imageScale, 1.0, imageScale),
                  alignment: Alignment.center,
                  child: Stack( // stack widgetleri üst üste yerlestiriyomus film afisim film baslıklarım vb üst üste gelmeliydi
                    children: <Widget>[
                      Container( // iflm afisini gösterir
                        width: MediaQuery.of(context).size.width,
                        height: height,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10), // Added margin
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://image.tmdb.org/t/p/original${movies[index].backDrop!}",
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
                      Positioned( // iflmbaslıgı
                        bottom: 30.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                movies[index].title!,
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
          SmoothPageIndicator( // kullanıcı hangi mvie de efekti
            controller: _pageController,
            count: movies.take(5).length,
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
