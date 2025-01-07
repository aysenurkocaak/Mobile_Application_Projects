

import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const  AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
    });

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(context) {
    return ElevatedButton(
      onPressed: onTap, //farklı cevaplar icin butonlara iht var
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(  //   // answer1 yazan metnin buton kenarlarından boslugu dikey ve yatay olarak ayrı dolgu ekliyoum
          vertical:10 , 
          horizontal: 40 
          ),
        backgroundColor: const Color.fromARGB(255, 64, 1, 94),
        foregroundColor: const Color.fromARGB(255, 188, 188, 188),
        shape: RoundedRectangleBorder(  // buton sekli 
          borderRadius: BorderRadius.circular(40),
          ),

      ),
      child: Text(answerText , textAlign: TextAlign.center),
    );
  }
}
