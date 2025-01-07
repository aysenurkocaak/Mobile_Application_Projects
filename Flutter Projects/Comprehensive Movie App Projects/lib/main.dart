import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/constant/style.dart';
import 'package:movie_app/model/hive_movie_model.dart';
import 'package:movie_app/model/hive_tv_model.dart';
import 'package:movie_app/screens/9.home_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env"); 
  await Hive.initFlutter(); // hive ile uyumlu calissin
  Hive.registerAdapter(HiveMovieModelAdapter());// adapterleri kaydeysin. Hive in bu veri modellerini dogru okuyup yazabilmesi icin gerekli
  Hive.registerAdapter(HiveTVModelAdapter());
  await Hive.openBox<HiveMovieModel>('movie_lists'); //bu kutular filmler ve tvshowları gibi verilerin yerel olarak saklanması icin
  await Hive.openBox<HiveTVModel>('tv_lists');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        scaffoldBackgroundColor: Style.primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Style.primaryColor,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}


