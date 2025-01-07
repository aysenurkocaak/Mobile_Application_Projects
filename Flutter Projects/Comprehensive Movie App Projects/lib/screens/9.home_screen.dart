
import 'package:flutter/material.dart';
import 'package:movie_app/constant/style.dart';
import 'package:movie_app/screens/1.tv_screen.dart';
import 'package:movie_app/screens/10.movie_screen.dart';
import 'package:movie_app/screens/watch_lists_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // hangi sayfada old. belirlemek icin
  
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // gecisi kontrol etmek icin
  void onTapIcon(int index) {
    _controller.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex != 2
          ? AppBar(
              centerTitle: true,
              title: _buildTitle(_currentIndex),
            )
          : null,
      body: PageView(
        // page görünümünü yarattim
        controller: _controller,
        children: const <Widget>[
          MovieScreen(),
          TVsScreen(),
          WatchLists(),
         
        ],
        onPageChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),

      // bottom nav bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Style.primaryColor,
        selectedItemColor: Style.secondColor,
        unselectedItemColor: Style.textColor,
        onTap: onTapIcon,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movies"),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: "TVs"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Watch Lists"),
        ],
      ),
    );
  }

// dinamik app bar title yapiyorum
  _buildTitle(int _index) {
    switch (_index) {
      case 0:
        return const Text('Movie Shows');
      case 1:
        return const Text('TV Shows');
      default:
        return null;
    }
  }
}

//bundan sonra movie screen in design ini yapcam
// sirayla:
// en üstte: now playing banner yapcam page indicator ile
//altında: genre list yapcam kategorileri kaydırabilmem lazım
//genreye göre select movie olcak
//en altlarda upcoming movies, popular movies.. olcak
// hepsine yildiz puanlaması koycam
