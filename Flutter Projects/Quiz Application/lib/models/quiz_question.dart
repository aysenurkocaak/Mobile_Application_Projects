/* 
bu widget iceren bir dosya degil bunun yerine soru planımı içeren 
bi dosya.

*/


class QuizQuestion {
  const QuizQuestion(this.text,
      this.answers); // farklı metinlere ve farklı cevaplara sahip farklı sinav sorusu nesneleri olusturmak icin gereken kurucu fonks.

  final String text; // gerçek soru metni
  final List<String> answers;

  List<String> getShuffleAnswers() {
    final shuffledList = List.of(answers);  //shuffle metodu orj dosyayı degistiriyo demiştik. öce kopya olusturduk kopyayı cagirdik ve güncellenmis list döndürülüyor
    shuffledList.shuffle();
    return shuffledList;
  }
}
