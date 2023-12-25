bool checkPalindrome(String text) {
  // menghilangkan space dan casefolding menjadi lowercase
  String cleanText = text.replaceAll(' ', '').toLowerCase();
  // membalikan text
  String reversedText = cleanText.split('').reversed.join();
  return cleanText == reversedText;
}
