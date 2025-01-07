import 'package:flutter/material.dart';
import 'package:question_app/data/questions.dart';
import 'package:question_app/qustions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.choosenAnswers, required this.onRestart});

  final List<String> choosenAnswers;
  final VoidCallback onRestart; // sadece ekran döncek bi deger cagrılmıcak o yüzden callback

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < choosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[
            0], // quesitos dosyasıda ilk cevap hep dogruydu o yüzden answers[0] yaptık
        'user_answer': choosenAnswers[i]
      });
    }

    return summary;
  }

  @override
  Widget build(context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length; //dogru cevaplanan soruların listesini degil sayısını istiyorum length o yuzden

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numTotalQuestions out of $numCorrectQuestions questions correctly!',
              style: const TextStyle(
                color:  Color.fromARGB(255, 133, 6, 172),
                fontSize: 12
              ),
            
            ),
            const SizedBox(
              height: 30,
            ),
            QustionsSummary(summaryData),
            const SizedBox(height: 30),
            TextButton.icon(
              onPressed: onRestart,
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              icon: const Icon(Icons.refresh),
              label: const Text(
                'Restart Quiz',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12
                ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
