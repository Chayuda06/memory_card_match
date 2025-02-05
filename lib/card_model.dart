class CardModel {
  String imageUrl;
  bool isFlipped;
  bool isMatched;

  CardModel({required this.imageUrl, this.isFlipped = false, this.isMatched = false});
}

