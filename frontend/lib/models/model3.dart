class Card{
  final int cardID;
  final int amount;

  const Card({
    required this.cardID,
    required this.amount,
  });
  factory Card.fromJson(Map<String,dynamic> json) => Card(
    cardID: json['cardID'],
    amount: json['amount'],
  );
  Map<String,dynamic> toJson()=>{
    "cardID":cardID,
    "amount":amount,
  };
}