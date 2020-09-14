import 'package:english_words/english_words.dart';

class WordGenerator {
  static String generateWordPair(){
    WordPair selectedWordPair;

    for(WordPair wordPair in generateWordPairs(safeOnly: false).take(5)){
      if(selectedWordPair == null){
        selectedWordPair = wordPair;
      }

      int wordLength = selectedWordPair.toString().length;
      if(wordLength > 20 || wordLength < 4){
        selectedWordPair = wordPair;
      }
    }

    //print('generated name: ${selectedWordPair.asPascalCase}');

    return selectedWordPair.asPascalCase;
  }
}