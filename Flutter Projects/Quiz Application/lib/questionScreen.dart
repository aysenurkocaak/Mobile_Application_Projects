import 'package:flutter/material.dart';
import 'package:question_app/answer_button.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:question_app/data/questions.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQustionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      currentQustionIndex++; //tıkladıgımızda bi sonraki soruya gecicek
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQustionIndex];

    return SizedBox(
      width: double.infinity, //ekranı ortalamak icin kullanılcak bişey
      child: Container(
        margin: const EdgeInsets.all(
            30), // cevappların old. butonlara sag sol bosluk ekledi
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment
              .stretch, // .stretch:  cevapların old. butonlar tüm sütun genişliginde olur.ama sagda solda hic bosluk kalmak
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 156, 156, 156),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center, // soruyu ortaladık
            ),
            const SizedBox(
              height: 30,
            ),

            ...currentQuestion.getShuffleAnswers().map(
              (answer) {
                // SHUFFLE : LİSTEDEKİ ÖGELERİN SİRASİNİ DEGİSTİRİR VE MAP TEN FARKI ORİJİNAL LİSTEYİ DE DEGİSTİRİR !!! questions dosyasına girdigimiz cevaplar karısık olarak gözükcek
                // basına ... koymak bi keyword. bu üç nota bi listedeki veya yinelenebilir dosyadaki tüm degerleri alıp bunları listeden cikarir ve buradaki koda yrlestirir.
                return AnswerButton(
                    answerText: answer,
                    onTap: () {
                      answerQuestion(answer);
                    });
              },
            ) // answers.add : listeye yeni öge ekler..  answers.map : dönüştürmeye dönüştürmemizi saglar.
          ],
        ),
      ),
    );
  }
}
