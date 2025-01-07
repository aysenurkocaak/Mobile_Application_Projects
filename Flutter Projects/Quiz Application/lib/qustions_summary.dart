import 'package:flutter/material.dart';

class QustionsSummary extends StatelessWidget {
  const QustionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        // bu metod: İçeriğimizin boyutu ekranı aştığı için  kaydırma olanağı sağlar.
        child: Column(
          children: summaryData.map(
            (data) {
              return Row(
                children: [
                  Text(
                    ((data['question_index'] as int) + 1).toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ), // question türü int tipinde ve buna 1 ekle
                  Expanded(
                    //Expanded widget'ı Column widget'ının yatay olarak mümkün olan en fazla alanı kaplamasını sağlar ve bu sayede metinlerin satır içinde düzgün şekilde hizalanmasını sağlar.
                    child: Column(
                      children: [
                        Text(
                          data['question'] as String? ?? 'question',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          data['user_answer'] as String? ?? 'user_answer',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 152, 11, 239),
                              fontSize: 15),
                        ),
                        Text(
                          data['correct_answer'] as String? ?? 'correct_answer',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 19, 149, 158),
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
