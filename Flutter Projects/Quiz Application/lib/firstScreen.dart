import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class Firstscreen extends StatelessWidget {
  const Firstscreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            color:const  Color.fromARGB(255, 255, 255, 255),
          ),
          const SizedBox(
            height: 80,
          ),
             Text(
            "Learn Flutter the fun way! ",
            style:  GoogleFonts.lato(
              color:const Color.fromARGB(255, 255, 255, 255),
              fontSize: 24,

            ),
          ),
          const SizedBox(
            height: 60,
          ),
          OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(foregroundColor: Colors.purple),
            icon: const Icon(Icons.arrow_right_alt, color: Colors.purple),
            label: const Text("Start Quiz"),
          ),
        ],
      ),
    );
  }
}
